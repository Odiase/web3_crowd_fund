# third party packages imports
from brownie import network, accounts, config, CrowdFundFactory

#local imports
from .helpers import get_account


def deploy_contract():
    account = get_account()

    # deploying contract
    contract_transaction = CrowdFundFactory.deploy({"from" : account})
    contract_transaction.wait(1)
    return contract_transaction
