/* --------------------------------------------------------------------------------
   DDL for table: t_ref_segment_2
   generated from Powerdesigner on Dienstag, 13. Juni 2023 19:04:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_segment_2 (
segment_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENT.'),
src_segment_nr BIGNUMERIC(38,0)
OPTIONS(description='Identifier of the segment in the segmentation in the source system, same segment numbers may exist for different segmentations within the same model, and in different models.'),
segment_name STRING(100) OPTIONS(description='Name of the segment in the segmentation.'),
segment_descr STRING(250) OPTIONS(description='Description of the segment in the segmentation.'),
segmentation_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SEGMENTATION.'),
segmentation_name STRING(100) OPTIONS(description='Name of the segmentation in the model.'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL.'),
model_name STRING(100) OPTIONS(description='Name of the model.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+, AP.'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH.'),
PRIMARY KEY (segment_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. A segment is a target bucket in a segmentation.');