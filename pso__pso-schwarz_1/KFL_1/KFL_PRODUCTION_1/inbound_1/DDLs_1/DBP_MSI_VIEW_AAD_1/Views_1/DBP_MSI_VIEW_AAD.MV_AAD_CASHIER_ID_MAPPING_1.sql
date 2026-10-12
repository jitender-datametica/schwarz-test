CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_AAD_CASHIER_ID_MAPPING_1
(
	HASHED_CASHIER_ID,
	MANDANT_ID,
	WUP_ID,
	KASSIERER_NR,
	HASH_GENERATION_DT,
	HASHED_CASHIER_BEZ
)
AS

--21.06.2023 snik: SPEC0200569 AAD_CASHIER_ID_MAPPING_1
--30.06.2023 twie: gekürzte Bezeichnung für Frontend Anzeige
/*26.08.2024 twie: SPEC0266321 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
  							   somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 
*/

SELECT 
      v01.hashed_cashier_id
    , v01.mandant_id
    , v02.aktuell_wup_id AS wup_id
    , v01.kassierer_nr
    , v01.hash_generation_dt
    , LEFT(v01.hashed_cashier_id, 30) AS hashed_cashier_bez
FROM DBP_VIEW.V_AAD_CASHIER_ID_MAPPING_1 v01

INNER JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;
