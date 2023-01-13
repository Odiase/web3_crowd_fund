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
    CROWD_FUND_NAME = "Call Of Duty Mobile"

    tx = contract.createCrowdFundContract(CROWD_FUND_NAME, DESCRIPTION, NAME, {"from" : account})
    tx.wait(1)

def get_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    CROWD_FUND_NAME = "Call Of Duty Mobiler"

    try:
        crowd_fund_tx = contract.getSingleCrowdFund(CROWD_FUND_NAME)
        # returned data
        crowd_fund_name = crowd_fund_tx[0]
        crowd_fund_owner = crowd_fund_tx[1]
        balance = crowd_fund_tx[2] / (1 * (10 ** 18))
        funders = crowd_fund_tx[3]

        print(f"The Crowd Fund '{crowd_fund_name}' which was Created by '{crowd_fund_owner}' and has a balance of {balance} ether   with this amount of funders {funders}")
    except:
        print("This CrowdFund Doesn't Exist")



def fund_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    name = "Call Of Duty Mobile"
    print("Account ; ", account)
    tx = contract.fund("Efosa", name, {"from" : account, "value" : 10000000000000000000})
    tx.wait(1)


def withdraw_funds():
    account = get_account()
    contract = get_factory_contract()

    name = "Call Of Duty Mobile"

    print("\n Withrawing.....\n")
    tx = contract.withdrawBalance(name, {"from" : account})
    tx.wait(1)
    print("Withdrawn!\n")

def get_crowd_fund_by_address(address):
    account = get_account()
    contract = get_factory_contract()

    tx = contract.getSingleCrowdFundByAddress(address)
    return tx

def get_user_crowdFunds():
    account = get_account()
    contract = get_factory_contract()

    NAME = "Efosa"

    crowd_fund_addresses = contract.getOwnerCrowdFunds(NAME)
    crowd_funds = [get_crowd_fund_by_address(i) for i in crowd_fund_addresses]
    print(crowd_funds)


def main():
    # create_crowd_fund()
    fund_crowd_fund()
    withdraw_funds()
    get_crowd_fund()
    #get_user_crowdFunds()

    