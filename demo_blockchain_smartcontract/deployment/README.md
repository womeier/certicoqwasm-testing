# Deploying the counter contract on Concordium testnet
## Setup 
- public key: 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU
- key file: 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU.export
- import key to CLI locally, see Concordium documentation
- account: [link to ccdscan](https://testnet.ccdscan.io/?dcount=2&dentity=account&daddress=3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU)
- input parameter for invoking smart contracts: file of 8 bytes containing an i64 in little endian, e.g. files zero, five, one
- counter.wasm: generated with `gh/womeier/certicoqwasm-testing` version [cff7a260](https://github.com/womeier/certicoqwasm-testing/commit/cff7a260e63eb1e51eaba0fe8795207dd47d17d7)

## Deploy
```
$ concordium-client module deploy counter.wasm --contract-version 1 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU --name counter --grpc-ip 37.27.96.169 --grpc-port 20001
```
<details><summary>OUTPUT</summary>
<p>
         
```
Warning: The module does not have embedded build information.
         It will likely not be possible to match this module to source code.
Proceed [yN]: y
y
Using default energy amount of 40775 NRG.
Deploy the module 'counter.wasm' and name it 'counter'.
Allowing up to 40775 NRG to be spent as transaction fee.
Confirm [yN]: y
y
Deploying module...
Enter password for credential with index 0 and signing key with index 0:
 Will send signed transaction to node.
Transaction '09e94691625d8230df19f05e991bc7b2b51a6a1432d430bd5283740a9faef8fc' sent to the node.
Waiting for the transaction to be committed and finalized.
You may skip this step by interrupting the command using Ctrl-C (pass flag '--no-wait' to do this by default).
The transaction will still get processed and may be queried using
  'concordium-client transaction status 09e94691625d8230df19f05e991bc7b2b51a6a1432d430bd5283740a9faef8fc'.
[21:07:26] Waiting for the transaction to be committed......
Transaction is finalized into block 4dc53f9629bf8d4a3b72146ab321172ca2246bd542494a4117ca064b09dd3ebb with status "success" and cost 2.753726 CCD (40774 NRG).
[21:07:33] Transaction finalized.
Module successfully deployed with reference: '8e2e2ab788837a44642e5221e43e5be8b435854bdf73f05f996f4792f45d5243'.
Module reference 8e2e2ab788837a44642e5221e43e5be8b435854bdf73f05f996f4792f45d5243 was successfully named 'counter'.
```

</p>
</details>

Success, module deployed: [link to ccdscan](https://testnet.ccdscan.io/?dcount=1&dentity=module&dmoduleReference=8e2e2ab788837a44642e5221e43e5be8b435854bdf73f05f996f4792f45d5243)

## Init contract (with 5)
```
$ concordium-client contract init 8e2e2ab788837a44642e5221e43e5be8b435854bdf73f05f996f4792f45d5243 --contract counter --energy 10000 --parameter-binary five --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU --grpc-ip 37.27.96.169 --grpc-port 20001
```
<details><summary>OUTPUT</summary>
<p>
         
```
Initialize contract 'counter' from module '8e2e2ab788837a44642e5221e43e5be8b435854bdf73f05f996f4792f45d5243' with binary parameters from 'five'. Sending 0.000000 CCD.
Allowing up to 10000 NRG to be spent as transaction fee.
Transaction expires on Thu,  8 Aug 2024 19:28:37 UTC.
Confirm [yN]: y
y
Enter password for credential with index 0 and signing key with index 0:
 Will send signed transaction to node.
Transaction 'ba2dc88483dc0c0d644490d6d868607475b0a0dc10540941e3d322e2f0f128ae' sent to the node.
Waiting for the transaction to be committed and finalized.
You may skip this step by interrupting the command using Ctrl-C (pass flag '--no-wait' to do this by default).
The transaction will still get processed and may be queried using
  'concordium-client transaction status ba2dc88483dc0c0d644490d6d868607475b0a0dc10540941e3d322e2f0f128ae'.
[21:18:41] Waiting for the transaction to be committed......
Transaction is finalized into block 58235870d113fe6f161bc0d2882287b662ae9dc38bef4dad917fa1dabb59a5e3 with status "success" and cost 0.110625 CCD (1638 NRG).
[21:18:47] Transaction finalized.
Contract successfully initialized with address: {"index":9851,"subindex":0}
```

</p>
</details>

succesfully initialized, can search on testnet.ccdscan.io for 9851,
returning created instance: [link to ccdscan](https://testnet.ccdscan.io/?dcount=1&dentity=contract&dcontractAddressIndex=9851&dcontractAddressSubIndex=0)

## View counter value
```
$ concordium-client contract invoke 9851 --entrypoint view --energy 10000 --grpc-ip 37.27.96.169 --grpc-port 20001
```
```
Invocation resulted in success:
 - Energy used: 1039 NRG
 - Return value (raw):
  [5,0,0,0,0,0,0,0]
 .
```

## Increment counter fail (try to increment by 0)
```
$ concordium-client contract update 9851 --entrypoint inc --parameter-binary zero --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU --grpc-ip 37.27.96.169 --grpc-port 20001
```
<details><summary>OUTPUT</summary>
<p>
         
```
Update contract 'counter' using the function 'inc' with binary parameters from 'zero'. Sending 0.000000 CCD.
Allowing up to 10000 NRG to be spent as transaction fee.
Transaction expires on Thu,  8 Aug 2024 19:45:04 UTC.
Confirm [yN]: y
y
Enter password for credential with index 0 and signing key with index 0:
 Will send signed transaction to node.
Transaction '5859dcf84e864f2137e70306c0e771071eb161a932d0b681be1c1c2cafbee340' sent to the node.
Waiting for the transaction to be committed and finalized.
You may skip this step by interrupting the command using Ctrl-C (pass flag '--no-wait' to do this by default).
The transaction will still get processed and may be queried using
  'concordium-client transaction status 5859dcf84e864f2137e70306c0e771071eb161a932d0b681be1c1c2cafbee340'.
[21:35:07] Waiting for the transaction to be committed......
Transaction is finalized into block 966c65ba3cf3d6dfb9e871047296ad7178daf713b3ce3e881a81220fa2535d26 with status "rejected" and cost 0.097698 CCD (1447 NRG).
Transaction rejected: runtime failure.
[21:35:13] Transaction finalized.
Error: Updating contract instance failed: Runtime failure.
```

</p>
</details>

this is expected, the increment can not be 0, see Counter.v in ConCert

## Increment counter success (increment by 1)
```
$ concordium-client contract update 9851 --entrypoint inc --parameter-binary one --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU --grpc-ip 37.27.96.169 --grpc-port 20001
```
<details><summary>OUTPUT</summary>
<p>
         
```
Update contract 'counter' using the function 'inc' with binary parameters from 'one'. Sending 0.000000 CCD.
Allowing up to 10000 NRG to be spent as transaction fee.
Transaction expires on Thu,  8 Aug 2024 19:46:39 UTC.
Confirm [yN]: y
y
Enter password for credential with index 0 and signing key with index 0:
 Will send signed transaction to node.
Transaction '9f762ef9d1456c753d9d4223027188b24138d5b460a245b47a1ff11dd8718025' sent to the node.
Waiting for the transaction to be committed and finalized.
You may skip this step by interrupting the command using Ctrl-C (pass flag '--no-wait' to do this by default).
The transaction will still get processed and may be queried using
  'concordium-client transaction status 9f762ef9d1456c753d9d4223027188b24138d5b460a245b47a1ff11dd8718025'.
[21:36:43] Waiting for the transaction to be committed......
Transaction is finalized into block 686adc8dbabb5b8d26f9df29fab889152ffa22fe8fb3c8e9090bb8b5e1f29c35 with status "success" and cost 0.101952 CCD (1510 NRG).
[21:36:49] Transaction finalized.
Successfully updated contract instance {"index":9851,"subindex":0} using the function 'inc'.
```

</p>
</details>

```
$ concordium-client contract invoke 9851 --entrypoint view --energy 10000 --grpc-ip 37.27.96.169 --grpc-port 20001
```
```
Invocation resulted in success:
 - Energy used: 1039 NRG
 - Return value (raw):
  [6,0,0,0,0,0,0,0]
 .
```

## Increment counter success (increment by 5)
```
$ concordium-client contract update 9851 --entrypoint inc --parameter-binary five --energy 10000 --sender 3KyTKQMeMF8G17R1kHRKy7Jh1R2osJutKtB3n8ucR9hYi9yLwU --grpc-ip 37.27.96.169 --grpc-port 20001
```
<details><summary>OUTPUT</summary>
<p>
         
```
Update contract 'counter' using the function 'inc' with binary parameters from 'five'. Sending 0.000000 CCD.
Allowing up to 10000 NRG to be spent as transaction fee.
Transaction expires on Thu,  8 Aug 2024 19:48:43 UTC.
Confirm [yN]: y
y
Enter password for credential with index 0 and signing key with index 0:
 Will send signed transaction to node.
Transaction '2d534764d5ac9e120be5c696de321dfb93abcc2664b88b9d7911a23b8a9bf279' sent to the node.
Waiting for the transaction to be committed and finalized.
You may skip this step by interrupting the command using Ctrl-C (pass flag '--no-wait' to do this by default).
The transaction will still get processed and may be queried using
  'concordium-client transaction status 2d534764d5ac9e120be5c696de321dfb93abcc2664b88b9d7911a23b8a9bf279'.
[21:38:47] Waiting for the transaction to be committed......
Transaction is finalized into block 78c3c0c60b075128f6cd6c16446c51caa55a5b215f08a0a4a6ffe840c85d278a with status "success" and cost 0.102087 CCD (1512 NRG).
[21:38:53] Transaction finalized.
Successfully updated contract instance {"index":9851,"subindex":0} using the function 'inc'.
```

</p>
</details>

```
$ concordium-client contract invoke 9851 --entrypoint view --energy 10000 --grpc-ip 37.27.96.169 --grpc-port 20001
```
```
Invocation resulted in success:
 - Energy used: 1039 NRG
 - Return value (raw):
  [11,0,0,0,0,0,0,0]
 .
```

## View transaction history
[link to ccdscan](https://testnet.ccdscan.io/?dcount=1&dentity=contract&dcontractAddressIndex=9851&dcontractAddressSubIndex=0)
