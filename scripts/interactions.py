from brownie import CrowdFundFactory, accounts, network
from .helpers import get_account, get_factory_contract


def create_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    NAME = 'Efosa'
    DESCRIPTION = '''
    This Crowd is to here to help refugees tht are stuck in the Ukraine and Russia War, and also 
    to send Relief materials and supplies.
    '''
    CROWD_FUND_NAME = "RON"

    tx = contract.createCrowdFundContract(CROWD_FUND_NAME, DESCRIPTION, NAME, {"from" : account})
    tx.wait(1)

def get_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    CROWD_FUND_NAME = "RON"

    try:
        crowd_fund_tx = contract.getSingleCrowdFund(CROWD_FUND_NAME)
    except:
        print("This CrowdFund Doesn't Exist")

    print(crowd_fund_tx)

    # returned data
    crowd_fund_name = crowd_fund_tx[0]
    crowd_fund_owner = crowd_fund_tx[1]
    balance = crowd_fund_tx[2] / (1 * (10 ** 18))
    funders = crowd_fund_tx[3]

    print(f"The Crowd Fund '{crowd_fund_name}' which was Created by '{crowd_fund_owner}' and has a balance of {balance} ether   with this amount of funders {funders}")


def fund_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    tx = contract.fund("Efosa", "RON", {"from" : account, "value" : 3000000000000000000})
    tx.wait(1)


def withdraw_funds():
    account = get_account()
    contract = get_factory_contract()

    tx = contract.withdrawBalance("RON", {"from" : account})
    tx.wait(1)


def main():
    # create_crowd_fund()
    # fund_crowd_fund()
    withdraw_funds()
    # get_crowd_fund()

    