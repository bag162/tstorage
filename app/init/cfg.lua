local cfg = {}

cfg.cfg = {
    log_level = 5,
    work_dir = '/tstorage',
    checkpoint_interval = 3600,
    checkpoint_count = 5,

    bucket_count = 100000,
    collect_bucket_garbage_interval = 5,
    replication_connect_quorum = 0,
    rebalancer_disbalance_threshold = 3,
    sharding = {
        
        ['cbf06940-0790-498b-948d-042b62cf3d29'] = {
            weight = 1000,
            replicas = {

                ['8a274925-a26d-47fc-9e1b-af88ce939412'] = {
                    uri = 'worker:FuEog86YW3Nnkjhg2WLC@185.251.90.90:3301',
                    name = 'storage_1_master',
                    master = true
                },

                ['3de2e3e1-9ebe-4d0d-abb1-26d301b84633'] = {
                    uri = 'worker:FuEog86YW3Nnkjhg2WLC@176.119.147.238:3310',
                    name = 'storage_1_replica'
                },
            },
        },
    },
}

return cfg;