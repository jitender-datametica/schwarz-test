CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETVERTRAG_PER_2
AS
-- 2009-06-18
-- FAKTVIEW mietvertrag_per (aktueller Datenstand)
-- Dummy_2-Verträge pro Land_2/Währung (union all)
-- 2009KW07 felder mietauftrag / option + Pruefung option 1 2 3 und verkettung
-- 2009KW17 EUR + LW über waehrungstyp
-- 2009KW27 Historisierung Kurs_2
-- 2011KW33 Cast mietvertrag_id beim DummyMietvertrag als Varchar(15) nach neuer Definition und konzessionär_id als Varchar(20)
-- 2011KW34 mietvertrag_option1 und 2 entfernt
-- 2011KW34 mietvertrag_nr hinzugefügt (notwendig für Anzeige)
-- 2011KW35 konzessionaer_id 0 auf '0'
-- 2011KW42 option_bez mit mietvertrag_option vorbelegt

SELECT
mv.mandant_id
,mv.mietvertrag_id
,mv.dat_von
,mv.dat_bis
,mv.dat_vertrag_beginn
,COALESCE(mv.dat_vertrag_ende, CAST('9999-12-31' AS DATE )) dat_vertrag_ende
,mv.vertragart_id
,mv.vertrag_status_fg
,mv.konzessionaer_id
,mv.vermieter_id
,CAST(CASE WHEN mv.dat_vertrag_ende BETWEEN CURRENT_DATE AND '9999-12-31'
THEN (dat_vertrag_ende - CURRENT_DATE) / 30
ELSE 0
END AS INTEGER) laufzeit_ende
,CAST(CASE WHEN mv.dat_vertrag_beginn BETWEEN '1900-01-31' AND CURRENT_DATE
THEN (CURRENT_DATE - dat_vertrag_beginn) / 30
ELSE 0
END AS INTEGER) laufzeit_beginn
,COALESCE(mv.dat_kuendbar_zum, CAST('9999-12-31' AS DATE )) dat_kuendbar_zum
,dat_kuendigung
,COALESCE(mv.kuendigung_frist, CAST(0 AS INTEGER)) AS kuendigung_frist
,COALESCE(mv.kuend_frist_bez, CAST('' AS VARCHAR(20))) AS kuend_frist_bez
,mv.betrag_kaution       * kurs_2 kaution
,mv.nebenkosten_betrag   * kurs_2 nebenkosten_betrag
,mv.nebenkosten_abschlag * kurs_2 nebenkosten_abschlag
,mv.sonderregelung_fg
,mv.mietindex_prozent
,mv.dat_mietindex
,mv.mietauftrag_id
,mv.mietvertrag_option
,mv.mietvertrag_option AS option_bez
,mv.debitor_miete_id    -- not used anymore
,mv.debitor_werbung_id  -- not used anymore
,kurs.wrg_id
,kurs.wrg_typ_id
,mv.mietvertrag_nr
FROM dbp_view.v_ivs_mietvertrag_per_2 mv

INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
ON kurs.mandant_id = mv.mandant_id
AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis

WHERE mv.dat_bis = '9999-12-31'

UNION ALL  -- Dummy_2-Mietvertrag (pro Mandant_2/Waehrung)

SELECT
mwt.mandant_id
,'0' AS mietvertrag_id
,CAST('1900-01-01' AS DATE ) AS dat_von
,CAST('9999-12-31' AS DATE ) AS dat_bis
,CAST('1900-01-01' AS DATE ) AS dat_vertrag_beginn
,CAST('9999-12-31' AS DATE ) AS dat_vertrag_ende
,'000'::CHAR(3) AS vertragart_id
,'0' ::CHAR(1) AS vertrag_status_fg
,'0' ::VARCHAR(20) AS konzessionaer_id
,(mwt.mandant_id * -1) ::INTEGER AS vermieter_id
,CAST (0 AS INTEGER) AS laufzeit_ende
,CAST (0 AS INTEGER) AS laufzeit_beginn
,CAST('9999-12-31' AS DATE ) AS dat_kuendbar_zum
,CAST('9999-12-31' AS DATE ) AS dat_kuendigung
,0 ::INTEGER AS kuendigung_frist
,'' ::VARCHAR(20) AS kuend_frist_bez
,0 ::DECIMAL(18,4) AS betrag_kaution
,0 ::DECIMAL(18,4) AS nebenkosten_betrag
,0 ::DECIMAL(18,4) AS nebenkosten_abschlag
,0 ::BYTEINT AS sonderregelung_fg
,0 ::DECIMAL(9,4) AS mietindex_prozent
,CAST('1900-01-01' AS DATE )  AS dat_mietindex
,0 ::BYTEINT mietauftrag_id
,''::VARCHAR(10) mietvertrag_option
,''::VARCHAR(40) AS option_bez
,0 ::DECIMAL(18,0) AS debitor_miete_id
,0 ::DECIMAL(18,0) AS debitor_werbung_id
,mwt.wrg_id
,mwt.wrg_typ_id
,'0' AS mietvertrag_nr
FROM dbp_view.v_mandant_wrg_typ_zu_2 mwt
;