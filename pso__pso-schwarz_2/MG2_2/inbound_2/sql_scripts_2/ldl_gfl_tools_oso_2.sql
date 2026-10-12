DELETE FROM  ETL_PROCESS.T_LOOKUP_INSTR_2 WHERE SOURCE_SYSTEM='oso';

INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
('xx','t_store_opening_hours_2','oso','xx','store_sid','store_sid','xx','store_natural_key','store_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid')
;
INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
('xx','t_store_opening_hours_2','oso','xx','store_sid','store_sid','xx','store_natural_key','store_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid')
;
INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
('xx','t_tcache_oso_internal_organization_hierarchy_2','oso','xx','parent_int_org_sid','parent_int_org_sid','xx','parent_int_org_natural_key','parent_int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid')
;
INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
('xx','t_tcache_oso_internal_organization_hierarchy_2','oso','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid')
;
INSERT INTO ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,TARGET_TABLE,SOURCE_SYSTEM,SOURCE_UNIQUE_NAME,SID_ALIAS,SID_NAME,TABLE_NAME,NATURAL_KEYS,TEMP_ALIAS_KEYS,ADD_TEMPORAL_JOIN,LKP_TABLE_AREA,KEYSPACE_SCHEMA,KEYSPACE_SUBJECT_AREA,KEYSPACE_KEY_TYPE_CD,KEYSPACE_NATURAL_KEY_NAME,KEYSPACE_SID_KEY_NAME) VALUES
('xx','t_tcache_oso_internal_organization_2','oso','xx','int_org_sid','int_org_sid','xx','int_org_natural_key','int_org_natural_key','no','meta','meta','party','party_key_type_cd','party_nat_key_nr','party_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2, TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,      SID_ALIAS,       SID_NAME, TABLE_NAME,         NATURAL_KEYS,        TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN, LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA,   KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(   'xx', 't_job_role_2',         'oso',               'xx', 'job_role_sid', 'job_role_sid',       'xx', 'job_role_nat_key_nr', 'job_role_nat_key_nr',               'no',        'meta',          'meta',            'job_role', 'job_role_key_type_cd',     'job_role_nat_key_nr',        'job_role_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2, TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,    SID_ALIAS,      SID_NAME, TABLE_NAME,      NATURAL_KEYS,   TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN, LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA, KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(   'xx', 't_job_role_2',         'oso',               'xx','int_org_sid', 'int_org_sid',       'xx', 'int_org_nat_key', 'int_org_nat_key',              'no',         'meta',          'meta',               'party',  'party_key_type_cd',        'party_nat_key_nr',           'party_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2, TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,                SID_ALIAS,                  SID_NAME, TABLE_NAME,                    NATURAL_KEYS,                   TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN,   LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA,  KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(   'xx', 't_job_role_2',         'oso',               'xx', 'reports_to_job_role_sid', 'reports_to_job_role_sid',       'xx', 'reports_to_job_role_nat_key_nr', 'reports_to_job_role_nat_key_nr',              'no',           'meta',           'meta',           'job_role', 'job_role_key_type_cd',    'job_role_nat_key_nr',        'job_role_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,          TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,      SID_ALIAS,         SID_NAME, TABLE_NAME,          NATURAL_KEYS,       TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN, LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA, KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(   'xx', 't_employee_job_role_2',         'oso',               'xx',  'job_role_sid',  'job_role_sid',       'xx', 'job_role_nat_key_nr', 'job_role_nat_key_nr',              'no',         'meta',          'meta',               'job_role', 'job_role_key_type_cd',     'job_role_nat_key_nr',        'job_role_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
(COUNTRY_2,          TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,  SID_ALIAS,       SID_NAME, TABLE_NAME,     NATURAL_KEYS,  TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN, LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA, KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(  'xx', 't_employee_job_role_2',         'oso',               'xx',  'emp_sid',      'emp_sid',       'xx', 'emp_nat_key_nr', 'emp_nat_key_nr',              'no',         'meta',          'meta',               'party',  'party_key_type_cd',        'party_nat_key_nr',           'party_sid')
;
insert into ETL_PROCESS.T_LOOKUP_INSTR_2 
( COUNTRY_2, TARGET_TABLE, SOURCE_SYSTEM, SOURCE_UNIQUE_NAME,    SID_ALIAS,     SID_NAME, TABLE_NAME,       NATURAL_KEYS,    TEMP_ALIAS_KEYS, ADD_TEMPORAL_JOIN, LKP_TABLE_AREA, KEYSPACE_SCHEMA, KEYSPACE_SUBJECT_AREA, KEYSPACE_KEY_TYPE_CD, KEYSPACE_NATURAL_KEY_NAME, KEYSPACE_SID_KEY_NAME) VALUES 
(    'xx',   't_person_2',         'oso',               'xx', 'person_sid', 'person_sid',       'xx', 'party_nat_key_nr', 'party_nat_key_nr',              'no',         'meta',          'meta',               'party',  'party_key_type_cd',        'party_nat_key_nr',           'party_sid')
;
