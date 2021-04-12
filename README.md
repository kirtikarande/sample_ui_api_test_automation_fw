# sample_ui_api_test_automation_fw

### **Setup** 
Use requirements file for required python library installation

`pip install -r requirements.txt`

### **Test Execution**
To run a single test: `robot -v ENV:prod -d <reports folder>  <testsuite path>`

Example: `robot -v ENV:prod tests/ui/login/login_*.robot`

To run critical tests using script:

`cd utils/`

`./run_critical_tests.py  <environment>  <results_folder>  <tests_folder>  <additional tags if any>`

### **Credits:**

Sample API server: https://jsonplaceholder.typicode.com/