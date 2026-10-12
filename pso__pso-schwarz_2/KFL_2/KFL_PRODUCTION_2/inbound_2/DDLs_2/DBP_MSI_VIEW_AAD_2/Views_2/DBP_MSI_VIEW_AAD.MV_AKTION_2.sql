CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_AKTION_2(
	AKTION_ID,
	MANDANT_ID,
	BEWART_ID,
	AKTIONSART_ID,
	WERBE_KAT_ID,
	DAT_VON,
	DAT_BIS,
	KJWO_VON
) AS
--08.08.2023 snik: SPEC0202038 AKTION_2
   SELECT
     v01.aktion_id
   , v01.mandant_id
   , v01.bewart_id
   , v01.aktionsart_id
   , v01.werbe_kat_id
   , v01.dat_von
   , v01.dat_bis
   , v01.kjwo_von
   FROM dbp_view.v_aktion_2 v01
;