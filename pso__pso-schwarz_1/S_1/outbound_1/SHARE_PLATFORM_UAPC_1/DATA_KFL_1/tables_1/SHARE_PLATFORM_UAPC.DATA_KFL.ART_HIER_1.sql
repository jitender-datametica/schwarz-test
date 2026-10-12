DROP TABLE IF EXISTS share_platform_uapc_data_kfl.art_hier_1;
CREATE OR REPLACE TABLE share_platform_uapc_data_kfl.art_hier_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abt_id BIGNUMERIC(38,0),
abt_bez STRING(400) COLLATE 'und:ci',
hwg_id BIGNUMERIC(38,0),
hwg_bez STRING(400) COLLATE 'und:ci',
owg_id BIGNUMERIC(38,0),
owg_bez STRING(400) COLLATE 'und:ci',
wg_id BIGNUMERIC(38,0),
wg_bez STRING(400) COLLATE 'und:ci',
wug_id BIGNUMERIC(38,0),
wug_bez STRING(160) COLLATE 'und:ci',
kl_art_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0),
kl_art_bez STRING(200) COLLATE 'und:ci'
) CLUSTER BY mandant_id;