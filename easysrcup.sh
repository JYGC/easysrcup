#!/bin/sh
#
# Update sources
#

BRANCH="netbsd-6-1-2-RELEASE";
PKGSRC="pkgsrc-2013Q4";
ARCH="amd64";

export CVS_RSH="ssh";
export CVSROOT="anoncvs@anoncvs.NetBSD.org:/cvsroot";

delete_src(){
	rm -rvf /usr/src;
}

fetch_src(){
	
	if [ -d /usr/src ];
	then
		cd /usr/src;
		pwd;
		cvs update -Pd;
	else
		cd /usr;
		pwd;
		cvs checkout -r $BRANCH -P src;
	fi
}

build_src(){
	
	if [ -d /usr/src ];
	then
		rm -rf /usr/obj/*;
		cd /usr/src;
		pwd;
		./build.sh -O ../obj -T ../tools -U -u distribution;
		./build.sh -O ../obj -T ../tools -U -u kernel=GENERIC;
	else
		echo "Need to fetch src first."
	fi
}

delete_xsrc(){
	rm -rvf /usr/xsrc;
}

fetch_xsrc(){

	if [ -d /usr/xsrc ];
	then
		cd /usr/xsrc;
		pwd;
		cvs update -Pd;
	else
		cd /usr;
		pwd;
		cvs checkout -r $BRANCH -P xsrc;
	fi
}

build_xsrc(){

	if [ -d /usr/xsrc ];
	then
		cd /usr/xsrc;
		pwd;

		echo "Not implemented yet.";
	else
		echo "need to fetch xsrc first.";
	fi
}

delete_pkgsrc(){
	rm -rvf /usr/pkgsrc;
}

fetch_pkgsrc(){
	
	if [ -d /usr/pkgsrc ];
	then
		cd /usr/pkgsrc;
		pwd;
		cvs update -dP
	else
		cd /usr;
		pwd;
		cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -r $PKGSRC -P pkgsrc
	fi
}

install_kernel(){
	cd /usr/obj/sys/arch/$ARCH/compile/GENERIC;
	pwd;
	mv /netbsd /netbsd.old;
	
	if [ -f /netbsd.old ];
	then
		cp netbsd /netbsd;
	fi
}

install_userland(){
	cd /usr/src
	./build.sh -O ../obj -T ../tools -U install=/
	/usr/sbin/etcupdate -s /usr/src
}

install_x11(){
	echo "?????"
}

if [ -f $0 ];
then
	if [ $1 = "fetch" ];
	then
		if [ $2 = "src" ];
		then
			if [ $3 = "new" ] || [ $4 = "new" ];
			then
				delete_src;
				fetch_src;
			else
				fetch_src;
			fi

			if [ $3 = "build" ];
			then
				build_src;
			fi

		elif [ $2 = "x11" ];
		then
			if [ $3 = "new" ] || [ $4 = "new" ];
			then
				delete_xsrc;
				fetch_xsrc;
			else
				fetch_xsrc;
			fi

			if [ $3 = "build" ];
			then
				build_xsrc;
			fi

		elif [ $2 = "pkgsrc" ];
		then
			if [ $3 = "new" ] || [ $4 = "new" ];
			then
				delete_pkgsrc;
				fetch_pkgsrc;
			else
				fetch_pkgsrc;
			fi
		
		else
			echo "Do nothing.";
		fi

	elif [ $1 = "build" ];
	then
		if [ $2 = "src" ];
		then
			build_src;

		elif [ $2 = "x11" ];
		then
			build_xsrc;
		else
			echo "Do nothing."
		fi

	elif [ $1 = "install" ];
	then

		if [ $2 = "kernel" ];
		then
			install_kernel;

		elif [ $2 = "userland" ];
		then
			install_userland;

		elif [ $2 = "x11" ];
		then
			install_x11;

		else
			echo "Do nothing.";
		fi
	else
		echo "Do nothing.";
	fi
fi
