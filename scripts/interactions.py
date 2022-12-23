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
    CROWD_FUND_NAME = "UkrRus"

    tx = contract.createCrowdFundContract(CROWD_FUND_NAME, DESCRIPTION, NAME, {"from" : account})
    tx.wait(1)

def get_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    CROWD_FUND_NAME = "UkrRus"

    try:
        crowd_fund_tx = contract.getSingleCrowdFund("UkrRus")
    except:
        print("This CrowdFund Doesn't Exist")

    print(crowd_fund_tx)


def fund_crowd_fund():
    account = get_account()
    contract = get_factory_contract()

    tx = contract.fund("Efosa", "UkrRus", {"from" : account, "value" : 3000000000000000000})
    tx.wait(1)

    # returned data
    crowd_fund_name = tx[0]
    crowd_fund_owner = tx[1]
    balance = tx[2]
    funders = tx[3]

    print(f"The Crowd Fund '{crowd_fund_name}' which was Created by '{crowd_fund_owner}' and has a balance of {balance} with this amount of funders {funders}")


def main():
    # create_crowd_fund()
    # fund_crowd_fund()
    get_crowd_fund()

    