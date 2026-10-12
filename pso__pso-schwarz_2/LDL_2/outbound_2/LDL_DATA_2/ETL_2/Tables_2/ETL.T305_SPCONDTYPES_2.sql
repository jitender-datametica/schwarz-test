CREATE TABLE IF NOT EXISTS ldl_data_etl.t305_spcondtypes_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c305_spcondnr INTEGER NOT NULL,
c305_spconddesc STRING(35) NOT NULL,
c305_defaultkrednr STRING(7),
c305_matchable INTEGER NOT NULL,
c305_includeinmarg INTEGER NOT NULL,
c305_sign INTEGER NOT NULL,
c305_weightcond INTEGER NOT NULL,
c305_spcondtype INTEGER NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c305_spcondnr) NOT ENFORCED
);