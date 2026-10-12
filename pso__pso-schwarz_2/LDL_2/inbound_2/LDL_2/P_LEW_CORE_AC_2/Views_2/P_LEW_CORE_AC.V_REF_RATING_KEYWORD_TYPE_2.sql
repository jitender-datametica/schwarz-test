CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_RATING_KEYWORD_TYPE_2
(
   rating_keyword_type_cd               COMMENT 'Code for the discriminator values for keyword types used in rating.'
   ,rating_keyword_type_descr           COMMENT 'A textual description for the discriminator value for keyword types used in rating.'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
) COMMENT = 'The minor dimension that contain keyword types used in rating ( for example Noun , Adjective , Verb , etc)'
AS
    SELECT 
        rating_keyword_type_cd
        ,rating_keyword_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_REF_RATING_KEYWORD_TYPE_2 ;
