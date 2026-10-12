CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_CRM_F_GUTSCHEIN_1
(
	CRM_GUTSCHEIN_ID,
	CRM_VORGANG_ID,
	CRM_GUTSCHEIN_GRUND_ID,
	GUTSCHEIN_NUMMER,
	KOSTENSTELLE_ID,
	MANDANT_ID,
	GUTSCHEIN_WERT,
	DAT_START,
	DAT_ENDE,
	DAT_START_PROCESSING,
	DAT_END_PROCESSING,
	SEC_KZ
) AS
-- 17.07.2019 twie: SPEC0059158  CRM Gutschein_1
-- 29.07.2019 twie: SPEC0059158  Tag_1 des Tickets ermitteln, damit Gutschein_1 unabhängig davon
-- 07.08.2019 twie: SPEC0060329 Securitykennzeichen definieren, 1 wie KDC
-- 12.10.2022 twie: SPEC0167837 sek_kz von 1 auf 3 geändert
-- 03.01.2022 twie: NSR3432488 dat_start als Datum gecastet
-- 18.10.2023 twie: SPEC0213119 mandant_id hinzu für Join auf kostenstelle_id
-- 02.05.2024 twie: SPEC0247600 neue Datumsfelder aus Vorgang
-- 09.05.2024 twie: SPEC0247600 Gutscheine mit -1 und NULL ausschließen, sind fachlich nicht relevant

   SELECT

     v01.crm_gutschein_id
   , v01.crm_vorgang_id
   , v01.crm_gutschein_grund_id
   , v01.gutschein_nummer
   , v01.kostenstelle_id
   , v01.mandant_id
   , v01.gutschein_wert
   , TO_DATE(v02.dat_start) AS dat_start
   , TO_DATE(v02.dat_ende) AS dat_ende
   , TO_DATE(v02.dat_start_processing) AS dat_start_processing
   , TO_DATE(v02.dat_end_processing) AS dat_end_processing
   , 3::BYTEINT AS sec_kz

   FROM dbp_view.v_crm_gutschein_1 v01

   INNER JOIN dbp_view.v_crm_vorgang_1 v02
   ON v01.crm_vorgang_id = v02.crm_vorgang_id
   
   WHERE v01.gutschein_nummer <> -1 AND v01.gutschein_nummer IS NOT NULL;