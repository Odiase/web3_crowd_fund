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

    crowd_fund_tx = contract.getSingleCrowdFund("UkrRus")

    print(crowd_fund_tx)

def main():
    # create_crowd_fund()
    get_crowd_fund()

    