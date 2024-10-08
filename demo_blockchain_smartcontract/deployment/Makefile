.PHONY: view_counter increase_1 increase_5 open_ccdscan
view_counter:
	concordium-client contract invoke 9851 --entrypoint view --energy 10000 --grpc-ip 37.27.96.169 --grpc-port 20001

increase_0:
	concordium-client contract update 9851 --entrypoint inc --parameter-binary zero --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU \
		--grpc-ip 37.27.96.169 --grpc-port 20001

increase_1:
	concordium-client contract update 9851 --entrypoint inc --parameter-binary one --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU \
		--grpc-ip 37.27.96.169 --grpc-port 20001

increase_5:
	concordium-client contract update 9851 --entrypoint inc --parameter-binary five --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU \
		--grpc-ip 37.27.96.169 --grpc-port 20001

open_ccdscan:
	chromium "https://testnet.ccdscan.io/?dcount=1&dentity=contract&dcontractAddressIndex=9851&dcontractAddressSubIndex=0"
