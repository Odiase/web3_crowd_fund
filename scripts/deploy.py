# third party packages imports
from brownie import network, accounts, config
from brownie import 

#local imports
from .helpers import get_account


def deploy_contract():
    account = get_account()
