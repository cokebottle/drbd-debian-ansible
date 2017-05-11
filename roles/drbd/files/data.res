#include "drbd.d/global_common.conf";

#include "drbd.d/*.res";

global { usage-count no; }

common { syncer { rate 100M; } }

resource r0 {

        protocol C;

        startup {

                wfc-timeout  15;

                degr-wfc-timeout 60;

        }

        net {

                cram-hmac-alg sha1;

                shared-secret "secret";

        }

        on node-01 {

                device /dev/drbd0;

                disk /dev/sdb;

                address 10.0.0.11:7788;

                meta-disk internal;

        }

        on node-02 {

                device /dev/drbd0;

                disk /dev/sdb;

                address 10.0.0.12       :7788;

                meta-disk internal;

        }

}
