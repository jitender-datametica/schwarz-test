CREATE OR REPLACE TABLE ldl_wawi_production_wawiadm.t213_item_feature_assignment_1 (
c213_id INTEGER NOT NULL,
c213_itemnr STRING(18) NOT NULL,
c213_featureid INTEGER NOT NULL,
c213_hqval INTEGER NOT NULL,
c213_whval INTEGER,
c213_dummy STRING(254),
scn INTEGER DEFAULT 0,
PRIMARY KEY (c213_id) NOT ENFORCED
);