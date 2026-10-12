CREATE OR REPLACE PROCEDURE dbp_macro.m_insert_art_kl_preislage_zu_per_neu(IN MANDANT_ID FLOAT64, IN ART_MATCHING_ID FLOAT64, IN KJMO FLOAT64, IN KJWO_UPDATE FLOAT64, IN WRG_ID STRING, IN SM_ID STRING, IN KSM_ID STRING, IN OWG_ID FLOAT64, IN WG_ID FLOAT64, IN WUG_ID FLOAT64, IN VK_BRUTTO_PK_1 FLOAT64, IN DURCHSCHNITT_PREIS_KASSE FLOAT64, IN UMSATZ_BRUTTO FLOAT64, IN UMSATZ_BRUTTO_AF FLOAT64, IN UMSATZ_BRUTTO_SA FLOAT64, IN MENGE FLOAT64, IN MENGE_AF FLOAT64, IN MENGE_SA FLOAT64)
BEGIN
DECLARE sql_stmt STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_stmt  =  '''INSERT INTO dbp_data.art_kl_preislage_zu_per_neu_2 (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id  , sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af,  umsatz_brutto_sa, menge, menge_af, menge_sa) (SELECT mandant_id,   art_matching_id,   kjmo,   kjwo_update,   wrg_id,   sm_id,   ksm_id,   owg_id,   wg_id,   wug_id,   vk_brutto_pk_1,   durchschnitt_preis_kasse,   umsatz_brutto,   umsatz_brutto_af,   umsatz_brutto_sa,   menge,   menge_af,   menge_sa  FROM dbp_data.art_kl_preislage_zu_per_neu_2) ''';

EXECUTE IMMEDIATE (sql_stmt);
SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
