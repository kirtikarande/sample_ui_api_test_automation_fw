#!/bin/bash
: '
Command to use this
./run_critical_tests.py  <environment>  <results_folder>  <tests_folder>  <additional tags if any>
'
echo "######### Started: `date` #########"

results_folder="$2"
results_folder_xml="$2/output.xml"
results_folder_rerun_xml="$2/rerun.xml"
results_rerun_to_merge_xml="$results_folder_xml"
tests_folder="$3"

environment="$1"

tags=" "
if [ "$#" -gt "3" ];then
	echo "tags input"
	echo "$4"
	tags="$4"
fi
echo $tags

mkdir -p "$results_folder"

pabot --processes 5   --verbose --name SampleTests  --variable ENV:$environment --variable TEST_TIMEOUT:'120s'  --include critical   $tags  -d $results_folder   -x junit_format.xml  $tests_folder
echo "Tests Executed"
sleep 5s  # to generate report
# echo "current dir: ${PWD}/../lib/result_robots.py"
number_failed=$(python ${PWD}/../lib/results_robot.py  $results_folder_xml)
echo "Failed Tests: $number_failed"

if [ $number_failed -gt 0 ]; then
  echo "Re-running failed tests..."
	robot --variable ENV:$environment --variable TEST_TIMEOUT:'120s'  --name SampleTests  $tags    --rerunfailed  $results_folder_xml  --output $results_folder_rerun_xml  $tests_folder
	results_rerun_to_merge_xml="$results_folder_rerun_xml"

  sleep 5s  #to generate report

	rebot -x junit_format.xml -d $results_folder  --merge  $results_folder_xml  $results_rerun_to_merge_xml

fi

echo "######### Completed: `date` #########"
