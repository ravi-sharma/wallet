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
 * Class Account
 */
class Account extends Eloquent
{
	const STATUS_ENABLED = 1;
	const STATUS_DISABLED = 2;
	const STATUS_SOFT_DELETED = -1;

	const TYPE_SAVING = 1;
	const TYPE_SALARY = 2;
	const TYPE_CORPORATIVE = 2;

	const HOLDER_SINGLE = 1;
	const HOLDER_JOINT = 2;

	/**
	 * @return bool|mixed
	 */
	public function getBalance()
	{
		if (!empty($this->balance)) {
			return $this->balance;
		}

		return false;
	}

	/**
	 * @return bool|mixed
	 */
	public function getStatus()
	{
		if (!empty($this->status)) {
			return $this->status;
		}

		return false;
	}

	/**
	 * @param     $parameters
	 * @param int $account_type
	 * @param int $holder_type
	 * @param int $status
	 *
	 * @return bool
	 */
	public function open($parameters, $account_type = self::TYPE_SAVING, $holder_type = self::HOLDER_SINGLE, $status = self::STATUS_ENABLED)
	{
		// Preparing data to pass
		$this->name           = $parameters['name'];
		$this->account_number = $parameters['account_number'];
		$this->account_type   = $account_type;
		$this->holder_type    = $holder_type;
		$this->balance        = $parameters['balance'];
		$this->status         = $status;

		return $this->save();
	}

	/**
	 * @param $account
	 *
	 * @return mixed
	 */
	public function isExist($account)
	{
		return Account::where('account_number', $account)->first();
	}

	/**
	 * @return mixed
	 */
	public function close()
	{
		$this->status = Account::STATUS_SOFT_DELETED;
		return $this->save();
	}

	/**
	 * @param $balance
	 *
	 * @return bool
	 */
	public function updateBalance($balance)
	{
		$this->balance = $balance;
		return $this->save();
	}

}

