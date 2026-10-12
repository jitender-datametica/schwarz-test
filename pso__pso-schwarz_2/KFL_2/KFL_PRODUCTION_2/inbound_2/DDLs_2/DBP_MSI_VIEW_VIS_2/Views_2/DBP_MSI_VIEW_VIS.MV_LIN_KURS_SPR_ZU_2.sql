CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_KURS_SPR_ZU_2
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   -- 20220707 snik1809 - Updated_NSR3003407_lin_kurs_id used instead of lin_kurs_bez
   -- 20240807 muellerpatri : Filter auf ungleich PRG hinzugefügt und Selbstjoin auf v_lin_kurs_spr_zu_2 entfernt
   -- 20240820 muellerpatri : Rückbau auf Selbstjoin
   -- 20250225 muellerpatri : Filter auf ungleich v2.PRG hinzugefügt 
(
	MANDANT_ID,
	LIN_KURS_ID,
	LIN_KURS_BEZ,
	LIN_KURS_BEZ_DE,
	LIN_KURS_BEZ_CZ,
	LIN_KURS_BEZ_PL,
	LIN_KURS_BEZ_SK,
	LIN_KURS_BEZ_HR,
	LIN_KURS_BEZ_RO,
	LIN_KURS_BEZ_BG
) AS
    SELECT
      v1.mandant_id
    , v1.lin_kurs_id
    , MAX(CASE WHEN v2.spr_id = 22  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez
    , MAX(CASE WHEN v2.spr_id = 22  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_de
    , MAX(CASE WHEN v2.spr_id = 124 THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_cz
    , MAX(CASE WHEN v2.spr_id = 90  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_pl
    , MAX(CASE WHEN v2.spr_id = 108 THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_sk
    , MAX(CASE WHEN v2.spr_id = 65  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_hr
    , MAX(CASE WHEN v2.spr_id = 95  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_ro
    , MAX(CASE WHEN v2.spr_id = 18  THEN v2.lin_kurs_bez ELSE v1.lin_kurs_id END) AS lin_kurs_bez_bg
    FROM dbp_view.v_lin_kurs_spr_zu_2 v1

    INNER JOIN dbp_view.v_lin_kurs_spr_zu_2 v2
    ON v1.lin_kurs_id = v2.lin_kurs_id

    WHERE v1.lin_bericht <> 'PRG'
    AND v2.lin_bericht <> 'PRG'

    GROUP BY
      v1.mandant_id
    , v1.lin_kurs_id;