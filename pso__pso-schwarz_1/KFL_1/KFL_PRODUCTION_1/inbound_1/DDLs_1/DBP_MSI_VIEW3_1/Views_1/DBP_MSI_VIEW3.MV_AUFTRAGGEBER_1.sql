CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_AUFTRAGGEBER_1

-- 27.07.2010 nb_id =99 (IWT Betriebe) in die Selektion aufgenommen
-- 2015.09.01. srom0404: INC0480245, Erweiterung um Gastro-Betriebe (nb_id = 2)
--šššššššššššššššššššššš laengengrad und breitengrad auch gleich mitgenommen
-- 22.02.2019 wg. IWT DE->Ausland 94/97.000er Kundennummern als AG mit dazu
-- 04.03.2019 wg. IWT DE->Ausland Kundennummern gem. Info von U. Pauls angepasst (eine_1 0 weniger)
(
auftraggeber_id
,mandant_id
,nb_id
,auftraggeber_bez
,vs_id
,wup_typ_id
,vkl_id
,dat_bis
,breitengrad
,laengengrad
)
AS
   SELECT
  CAST(wup_id AS VARCHAR(10)) AS auftraggeber_id, mandant_id, nb_id, CASE WHEN nb_id = -1 THEN '---' ELSE wup_standort END AS auftraggeber_bez, vs_id, wup_typ_id, vkl_id, dat_bis, breitengrad, laengengrad
   FROM dbp_view.v_wup_1
   WHERE (nb_id IN (0, 99, 2, -111) AND wup_id > 0)
   OR (nb_id = -1 AND wup_id = 0)

   UNION ALL

   SELECT
   CAST(REPLACE(kunde_nr,'0000', '000') as VARCHAR(10)) as auftraggeber_id,
   mandant_id,
   0 AS nb_id,
   kunde_name AS auftraggeber_bez,
   0 AS vs_id,
   0 AS wup_typ_id,
   -1 AS vkl_id,
   cast('9999-12-31' AS date) AS dat_bis,
   NULL AS breitengrad,
   NULL AS laengengrad
   FROM dbp_view.v_in_kunde_1 WHERE mandant_id=1 AND (SUBSTR(kunde_nr, 1, 5) = '97000' OR SUBSTR( kunde_nr, 1, 5) = '94000')
;