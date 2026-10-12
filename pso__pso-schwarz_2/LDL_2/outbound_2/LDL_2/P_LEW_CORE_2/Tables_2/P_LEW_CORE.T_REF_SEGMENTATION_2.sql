CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_segmentation_2 (
segmentation_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENTATION'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
segmentation_name STRING(100) OPTIONS(description='NAMe of the segmentation in the model'),
segmentation_descr STRING(250) OPTIONS(description='DEScription of the segmentatzion in the model'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (segmentation_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. a segmentation is a set of rules and calculations to calculate scores and assign certain entities to certain segments.');