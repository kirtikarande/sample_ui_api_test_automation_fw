import time

from Selenium2Library import Selenium2Library
from robot.api.deco import keyword
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait


# from logilab.common.proc import TimeoutError

# create new class that inherits from Selenium2Library
class custom_selenium_library(Selenium2Library):
    # create a new keyword called "get webdriver instance"

    def get_current_title(self):
        driver = self._current_browser()
        title = driver.title
        print(title)
        return title

    #def get