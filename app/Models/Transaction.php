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

use Illuminate\Database\Eloquent\Model as Eloquent;

/**
 * Class Transaction
 */
class Transaction extends Eloquent
{
	const TYPE_DEBIT = 1;
	const TYPE_CREDIT = 2;

	const VIA_CHQUE = 1;
	const VIA_ATM = 2;
	const VIA_NEFT = 3;
	const VIA_CASH = 4;
	const VIA_BANK = 5;

	const TRANSFER_LIMIT = 100000;
	const SERVICE_CHARGE = 100;

	/**
	 * @param $dataContainer
	 * @param $type
	 * @param $via
	 *
	 * @return mixed
	 */
	public function create($dataContainer, $type, $via)
	{
		// Preparing data to pass
		$this->account_number   = $dataContainer['account_number'];
		$this->transaction_type = $type;
		$this->source_type      = $via;
		$this->amount           = $dataContainer['amount'];
		$this->remarks          = $dataContainer['remarks'];

		$this->save();

		return $this->id;
	}

}

