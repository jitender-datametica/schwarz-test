create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_VS_2(
	MANDANT_ID,
	VS_ID,
	MA_ANREDE,
	MA_NAME,
	MA_VORNAME,
	VSVT_BEZ
) as
-- 19.09.2013 twie: Kopie aus VIS mv_vs_2
-- 15.01.2014 twie: vs_bez entfernt
-- 08.09.2016 twie: SPEC0014329 geänderte Where Bedingung von VIS View übernommen
-- 23.08.2018 twie: SPEC0038139 vsvt_bez aufnehmen
-- 20.03.2024 twie: Join ma_spr_zu_2 zu LEFT JOIN, da es bspw. bei DE und PL noch die vs_id = 0 in den Fakten gibt
--					aber keinen zugeordneten MA Namen mehr. Hier wird stattdessen die vsvt_bez ausgegeben, damit der Datensatz nicht entfällt

   SELECT
     v01.mandant_id
   , v01.vs_id
   , COALESCE(v03.ma_anrede, '') AS ma_anrede
   , COALESCE(v03.ma_name, v01.vsvt_bez) AS ma_name
   , COALESCE(v03.ma_vorname, '') AS ma_vorname
   , v01.vsvt_bez
   FROM dbp_view.v_vs_2 v01

   JOIN (
   SELECT DISTINCT
     w.mandant_id
   , w.vs_id
   , MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id) AS gl_vertrieb_id
   FROM dbp_view.v_wup_2 w
   
   LEFT JOIN dbp_msi_v_view.v_wup_denorm_2 wd
   ON w.mandant_id = wd.mandant_id
   AND w.wup_id=wd.wup_id

   WHERE w.nb_id IN (-2, -1, 0)
   AND dat_eroeffnung < '9999-12-31' -- NUR bekannte eroeffnungen
   AND dat_bis = '9999-12-31' -- OHNE schliessungen
   ) v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id

   LEFT JOIN dbp_view.v_ma_spr_zu_2 v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.gl_vertrieb_id = v03.ma_id
   AND v03.spr_id=22;