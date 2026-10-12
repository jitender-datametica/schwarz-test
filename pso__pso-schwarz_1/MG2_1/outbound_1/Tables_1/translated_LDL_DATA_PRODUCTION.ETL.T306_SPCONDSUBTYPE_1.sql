CREATE OR REPLACE TABLE ldl_data_production_etl.t306_spcondsubtype_1 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
c306_spsubnr INTEGER NOT NULL,
c306_spcondnr INTEGER NOT NULL,
c306_spsubtype INTEGER NOT NULL,
c306_spsubdesc STRING(80) NOT NULL,
c306_spsubmatchabl INTEGER NOT NULL,
c306_spsubinclmarg INTEGER NOT NULL,
c306_spsubsign INTEGER NOT NULL,
c306_weightcond INTEGER NOT NULL,
c306_assignspcond INTEGER,
c306_spsubcondtype INTEGER NOT NULL,
scn INTEGER DEFAULT 0,
c306_active_flag INTEGER,
extraction_tmsp DATETIME,
PRIMARY KEY (c306_spsubnr) NOT ENFORCED
);