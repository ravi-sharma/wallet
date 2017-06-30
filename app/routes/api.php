<?php

# @author Ravi Sharma <me@rvish.com>

# Copyright (c) 2017 Ravi Sharma (http://www.rvish.com)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// Open account
$app->post('/api/account/open', function (Request $request, Response $response) {

	$account = new Account();

	// Check if account already exist
	if ($account->isExist($request->getParam('account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Account number already exits']);
	}

	// Let's create the account
	if ($account->open($request->getQueryParams())) {
		return $response->withJson(['status' => 'success', 'id' => $account]);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Somthing went wrong, please try again later']);
	}
});

// Close account
$app->put('/api/account/close', function (Request $request, Response $response) {

	$account = new Account();

	// Check if account already exist
	if (!$account = $account->isExist($request->getParam('account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Account number does not exits']);
	}

	// Closing account
	if ($account->close()) {
		return $response->withJson(['status' => 'success']);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Account does not close']);
	}
});

// Get balance
$app->get('/api/account/getBalance', function (Request $request, Response $response) {

	$account = new Account();

	// Check if account already exist
	if (!$account = $account->isExist($request->getParam('account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Account number does not exits']);
	}

	// Get balance
	if ($result = $account->getBalance()) {
		return $response->withJson(['status' => 'success', 'data' => $result]);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Account not found !']);
	}
});

// Withdraw money
$app->post('/api/transaction/withdraw', function (Request $request, Response $response) {

	$account = new Account();

	// Check if account already exist
	if (!$account = $account->isExist($request->getParam('account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Account number does not exits']);
	}

	$balance = $account->getBalance();

	// Check if balance is sufficient for the transaction
	if ($balance < $request->getParam('amount')) {
		return $response->withJson(['status' => 'failed', 'error' => 'Insufficient account balance']);
	}

	// Mark a transaction
	$transaction = new Transaction();

	$transaction->create($request->getQueryParams(), Transaction::TYPE_DEBIT, Transaction::VIA_BANK);

	// Update balance
	$account->updateBalance(intval($balance - $request->getParam('amount')));

	if ($account->save()) {
		return $response->withJson(['status' => 'success', 'data' => $transaction]);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Somthing went wrong, please try again later']);
	}
});

// Deposit money
$app->post('/api/transaction/deposit', function (Request $request, Response $response) {

	$account = new Account();

	// Check if account already exist
	if (!$account = $account->isExist($request->getParam('account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Account number does not exits']);
	}

	$balance = $account->getBalance();

	// Mark a transaction
	$transaction = new Transaction();

	$transaction->create($request->getQueryParams(), Transaction::TYPE_CREDIT, Transaction::VIA_BANK);

	// Update balance
	$account->updateBalance(intval($balance + $request->getParam('amount')));

	if ($account->save()) {
		return $response->withJson(['status' => 'success', 'data' => $transaction]);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Somthing went wrong, please try again later']);
	}
});


// Transfer money
$app->post('/api/transaction/transfer', function (Request $request, Response $response) {

	$from_account = new Account();

	// Check if account already exist
	if (!$from_account = $from_account->isExist($request->getParam('from_account_number'))) {
		return $response->withJson(['status' => 'failed', 'error' => 'Sender account number does not exits']);
	}

	$balance = $from_account->getBalance();

	// Check if balance is sufficient for the transaction
	if ($balance < $request->getParam('amount')) {
		return $response->withJson(['status' => 'failed', 'error' => 'Insufficient account balance']);
	}

	$todayTransfer = Transaction::where('account_number', $request->getParam('from_account_number'))
								->where('transaction_type', Transaction::TYPE_DEBIT)
								->where('source_type', Transaction::VIA_NEFT)
								->whereDay('created_at', date('d'))
								->sum('amount');

	// Check transfer limit
	if ($todayTransfer + $request->getParam('amount') > Transaction::TRANSFER_LIMIT) {
		return $response->withJson(['status' => 'failed', 'error' => 'Daily transfer limit is getting exceeded, choose lesser amount']);
	}

	// Check service charge
	$service_charge = Transaction::SERVICE_CHARGE;

	$to_account = new Account();

	// Check if receiver has account already exist
	if (!$to_account = $to_account->isExist($request->getParam('to_account_number'))) {

		// Open receiving account
		$to_account = new Account();

		$parameters['name']           = $request->getParam('name');
		$parameters['account_number'] = $request->getParam('to_account_number');
		$parameters['balance']        = 0;

		$to_account->open($parameters);
	}

	if ($from_account->name == $to_account->name) {
		$service_charge = 0;
	} else {
		// Check third party response
		$json   = @file_get_contents('http://handy.travel/test/success.json');
		$result = @json_decode($json);

		if ($result->status !== 'success') {
			return $response->withJson(['status' => 'failed', 'error' => 'Somthing went wrong, please try again later']);
		}
	}

	// Debit
	$transaction            = new Transaction();
	$data                   = $request->getQueryParams();
	$data['account_number'] = $request->getParam('from_account_number');
	$data['amount']         = $request->getParam('amount') + $service_charge;

	$transaction->create($data, Transaction::TYPE_DEBIT, Transaction::VIA_NEFT);

	// Update the account
	$from_account->updateBalance(intval($balance - $request->getParam('amount') - $service_charge));

	// Credit
	$transaction            = new Transaction();
	$data                   = $request->getQueryParams();
	$data['account_number'] = $request->getParam('to_account_number');

	$transaction->create($data, Transaction::TYPE_CREDIT, Transaction::VIA_NEFT);

	$balance = $to_account->getBalance();

	// Update the account
	if ($to_account->updateBalance(intval($balance + $request->getParam('amount')))) {
		return $response->withJson(['status' => 'success', 'data' => $transaction]);
	} else {
		return $response->withJson(['status' => 'failed', 'error' => 'Somthing went wrong please try again later']);
	}
});