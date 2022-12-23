from brownie import CrowdFundFactory, accounts, network
from .helpers import get_account


def create_crowd_fund():
    # getting account to work with
    account = get_account()

    