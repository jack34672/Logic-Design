webtalk_init -webtalk_dir D:/Jack/NTHU/2018_spring/LD exp/Lab02/Lab02/Lab02.hw/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Mon Mar 12 17:34:36 2018" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "Vivado v2016.2 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "1577090" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "WIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "c019c692-1fa4-4c5a-bddb-506d77eb6b53" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "ad0e25d9-597f-4441-80ce-6a2b53e5d2a1" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "4" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Microsoft Windows 8 or later , 64-bit" -context "user_environment"
webtalk_add_data -client project -key os_release -value "major release  (build 9200)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "2592 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client labtool
webtalk_add_data -client labtool -key chain -value "0362D093" -context "labtool\\usage"
webtalk_add_data -client labtool -key pgmcnt -value "01:00:00" -context "labtool\\usage"
webtalk_add_data -client labtool -key cable -value "Digilent/Basys3/15000000:" -context "labtool\\usage"
webtalk_transmit -clientid 1796412742 -regid "" -xml D:/Jack/NTHU/2018_spring/LD exp/Lab02/Lab02/Lab02.hw/webtalk/usage_statistics_ext_labtool.xml -html D:/Jack/NTHU/2018_spring/LD exp/Lab02/Lab02/Lab02.hw/webtalk/usage_statistics_ext_labtool.html -wdm D:/Jack/NTHU/2018_spring/LD exp/Lab02/Lab02/Lab02.hw/webtalk/usage_statistics_ext_labtool.wdm -intro "<H3>LABTOOL Usage Report</H3><BR>"
webtalk_terminate
