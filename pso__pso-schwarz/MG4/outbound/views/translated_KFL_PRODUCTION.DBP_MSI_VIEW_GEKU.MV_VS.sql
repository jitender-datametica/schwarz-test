-- 19.09.2013 twie: Kopie aus VIS mv_vs
 -- 15.01.2014 twie: vs_bez entfernt

-- 20.03.2024 twie: CROSS JOIN ma_spr_zu zu LEFT JOIN, da es bspw. bei DE und PL noch die vs_id = 0 in den Fakten gibt

-- aber keinen zugeordneten MA Namen mehr. Hier wird stattdessen die vsvt_bez ausgegeben, damit der Datensatz nicht entfällt

-- 23.08.2018 twie: SPEC0038139 vsvt_bez aufnehmen

-- 08.09.2016 twie: SPEC0014329 geänderte Where Bedingung von VIS View übernommen

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_vs (mandant_id, vs_id, ma_anrede, ma_name, ma_vorname, vsvt_bez) AS
-- NUR bekannte eroeffnungen
 -- OHNE schliessungen
 SELECT v01.mandant_id,
 v01.vs_id,
 COALESCE(v03.ma_anrede, '') AS ma_anrede,
 COALESCE(v03.ma_name, v01.vsvt_bez) AS ma_name,
 COALESCE(v03.ma_vorname, '') AS ma_vorname,
 v01.vsvt_bez
FROM kfl_production_dbp_view.v_vs AS v01
 INNER JOIN (SELECT DISTINCT w.mandant_id,
   w.vs_id,
   MAX(wd.gl_vertrieb_id) OVER (PARTITION BY w.mandant_id, w.vs_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS gl_vertrieb_id
  FROM kfl_production_dbp_view.v_wup AS w
   LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS wd ON w.mandant_id = wd.mandant_id AND w.wup_id = wd.wup_id
  WHERE w.nb_id IN (- 2, - 1, 0)
   AND w.dat_eroeffnung < DATE '9999-12-31'
   AND w.dat_bis = DATE '9999-12-31') AS v02 ON v01.mandant_id = v02.mandant_id AND v01.vs_id = v02.vs_id
 LEFT JOIN kfl_production_dbp_view.v_ma_spr_zu AS v03 ON v02.mandant_id = v03.mandant_id AND v02.gl_vertrieb_id = v03.ma_id
     AND v03.spr_id = 22;