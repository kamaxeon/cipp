# Makefile for CIPP
#


KT=kitchen
VG=vagrant
PK=packer
PACKER_FILE=packer/ubuntu_14.04x64.json

# target: help - Display callable targets.
help:
	@egrep "^# target:" [Mm]akefile

# target: k-converge - Run kitchen converge
k-converge:
	$(KT) converge

# target: k-verify - Run kitchen verify
k-verify:
	$(KT) verify

# target: k-test - Run kitchen test
k-test:
	$(KT) test

# target: k-login - Run kitchen login
k-login:
	$(KT) login

# target: k-destroy - Run kitchen destroy
k-destroy:
	$(KT) destroy

# target: k-list - Run kitchen list
k-list:
	$(KT) list

# target: v-provision - Run vagrant provision
v-provision:
	$(VG) provision

# target: v-destroy - Run vagrant destroy
v-destroy:
	$(VG) destroy -f

# target: v-create - Run vagran up using the virtualbox provider
v-create: 
	$(VG) up --provider=virtualbox

# target: v-recreate - Destroy and create the VM using vagrant
v-recreate: v-destroy v-create

# target: v-login - Run login ssh
v-login:
	$(VG) ssh

v-st: v-status

# target: v-halt - Run vagrant halt
v-halt:
	$(VG) halt

# target: v-status - Run vagran status
v-status: 
	@$(VG) status


# target: verify-syntax - Verify the syntax for packer file
validate-build:
	echo "Verifying the syntax of the packer file"
	@$(PK) validate $(PACKER_FILE)

# target: build - Create Virtual Machines with packer.
build: validate-build
	echo "Creating VM's with packer"
	@$(PK) build --force packer/ubuntu_14.04x64.json
