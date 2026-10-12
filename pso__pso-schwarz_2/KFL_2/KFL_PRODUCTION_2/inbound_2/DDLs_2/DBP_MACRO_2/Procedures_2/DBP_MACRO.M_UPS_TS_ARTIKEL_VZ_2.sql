CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_ARTIKEL_VZ(
    "P_MANDANT_ID" FLOAT, 
    "P_KJWO" FLOAT, 
    "P_ANGEBOT_ID" FLOAT, 
    "P_AKTION_ID" VARCHAR(10), 
    "P_AUSLIEFERGRUPPE_ID" VARCHAR(10), 
    "P_ART_ID" FLOAT, 
    "P_WUP_ID_VZ" FLOAT, 
    "P_NB_ID_VZ" FLOAT, 
    "P_MANDANT_ID_VZ" FLOAT, 
    --"P_BEZUGSWEG_ID" FLOAT, 
    --"P_GP_ID" FLOAT, 
    "P_CLEAR_STOCK_FG"  VARCHAR(100), 
    --"P_LIEFERUNG_TAG_OFFSET" FLOAT, 
    "P_ESTIMATION_FG" FLOAT, 
    "P_MAX_KAPA_FG" FLOAT, 
    "P_ADJUSTMENT_FG" FLOAT, 
    "P_DAT_LETZTE_NACHVERSORGUNG" VARCHAR(16777216), 
    "P_CHECK_CLEAR_STOCK" VARCHAR(100))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
AS  $$

DECLARE 
dummy_2 float; 

BEGIN

DELETE FROM  DBP_DATA.ts_wbs_artikel_vz_2
WHERE  mandant_id = :P_MANDANT_ID
		AND kjwo = :P_KJWO
		AND angebot_id = :P_ANGEBOT_ID
		AND aktion_id = :P_AKTION_ID
		AND ausliefergruppe_id = :P_AUSLIEFERGRUPPE_ID
		AND art_id = :P_ART_ID
		AND wup_id_vz = :P_WUP_ID_VZ
		AND nb_id_vz = :P_NB_ID_VZ
		AND mandant_id_vz = :P_MANDANT_ID_VZ
        ;


INSERT INTO DBP_DATA.ts_wbs_artikel_vz_2 (mandant_id, kjwo, angebot_id, aktion_id, ausliefergruppe_id, art_id, wup_id_vz, nb_id_vz, mandant_id_vz, bezugsweg_id, gp_id, clear_stock_id, lieferung_tag_offset, estimation_fg, max_kapa_fg, adjustment_id, dat_letzte_nachversorgung)
 
    SELECT 
    :P_MANDANT_ID, :P_KJWO, :P_ANGEBOT_ID, :P_AKTION_ID, :P_AUSLIEFERGRUPPE_ID, :P_ART_ID, :P_WUP_ID_VZ, :P_NB_ID_VZ, :P_MANDANT_ID_VZ, -9,-9,
    -- wenn Clearstock nicht geandert wurde dann wird die Bezeichnung uebergeben 
    -- In Check clear stock steht die ID vom aktuellen Clear Stock 
    CASE WHEN try_to_number(:P_CLEAR_STOCK_FG) IS NOT NULL THEN :P_CLEAR_STOCK_FG ELSE 
       :P_CHECK_CLEAR_STOCK
    END     
    , NULL , :P_ESTIMATION_FG, :P_MAX_KAPA_FG, :P_ADJUSTMENT_FG, :P_DAT_LETZTE_NACHVERSORGUNG;

COMMIT;
RETURN 'Artikel_2 gespeichert';

END;
$$;