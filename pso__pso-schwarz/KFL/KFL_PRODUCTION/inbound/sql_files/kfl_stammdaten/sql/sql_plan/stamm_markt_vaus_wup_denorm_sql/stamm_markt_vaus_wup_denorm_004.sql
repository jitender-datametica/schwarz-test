CREATE OR REPLACE TABLE DBP_ETL.wup_denorm_tmp LIKE DBP_MSI_DATA.wup_denorm;

INSERT INTO DBP_ETL.wup_denorm_tmp
(
   mandant_id
  ,wup_id
  ,bed_fleisch_fg
  ,bed_fleisch_dat
  ,bed_wurst_fg
  ,bed_wurst_dat
  ,bed_gefl_fg
  ,bed_gefl_dat
  ,bed_kaese_fg
  ,bed_kaese_dat
  ,bed_fisch_id
  ,bed_fisch_dat
  ,bed_feink_fg
  ,bed_feink_dat
  ,bed_bulk_fg
  ,bed_bulk_dat
  ,bed_bedins_fg
  ,bed_bedins_dat
  ,bed_imbiss_fg
  ,bed_imbiss_dat
  ,bed_backshop_fg
  ,bed_backshop_dat
  ,backshop_system
  ,leergut_system
  ,anz_leergutautomaten
  ,glv_land_id
  ,stv_glv_land_id 
  ,gl_vertrieb_id
  ,gf_gbl_vertrieb_id
  ,vkl_id
  ,hausleiter_id
  ,wbl_food_id
  ,wbl_frische_id
  ,wbl_nonfood_id
  ,wbl_kasse_id
  ,frische_manager_id
  ,regionale_psb_id
  ,tankstelle_vorh_fg
  ,tankstelle_eigen_fg
  ,ma_vermietung_id
  ,eigentum_fg
  ,dat_letzte_reorga
  ,parkhaus_kz
  ,getraenkemarkt_kz
  ,anz_aufzuege
  ,anz_rollsteige
  ,anz_aufzuege_intern
  ,anz_rollsteige_intern
  ,untervermietung_kz
  ,untervermietung_text
  ,untervermietung_freitext
  ,hausleiter_sperr_fg
  ,vkl_sperr_fg
  ,gf_gbl_vertrieb_sperr_fg
)
SELECT
   w.mandant_id
  ,w.wup_id
  ,0 AS bed_fleisch_fg
  ,NULL AS bed_fleisch_dat
  ,0 AS bed_wurst_fg
  ,NULL AS bed_wurst_dat
  ,0 AS bed_gefl_fg
  ,NULL AS bed_gefl_dat
  ,0 AS bed_kaese_fg
  ,NULL AS bed_kaese_dat
  ,1 AS bed_fisch_id /*1 = nix*/
  ,NULL AS bed_fisch_dat
  ,0 AS bed_feink_fg
  ,NULL AS bed_feink_dat
  ,0 AS bed_bulk_fg
  ,NULL AS bed_bulk_dat
  ,0 AS bed_bedins_fg
  ,NULL AS bed_bedins_dat
  ,0 AS bed_imbiss_fg
  ,NULL AS bed_imbiss_dat
  ,0 AS bed_backshop_fg
  ,NULL AS bed_backshop_dat
  ,'' AS backshop_system
  ,'' AS leergut_system
  ,0 anz_leergutautomaten
  ,-1 AS glv_land_id
  ,-1 AS stv_glv_land_id
  ,-1 AS gl_vertrieb_id
  ,-1 AS gf_gbl_vertrieb_id
  ,-1 AS vkl_id
  ,-1 AS hausleiter_id
  ,-1 AS wbl_food_id
  ,-1 AS wbl_frische_id
  ,-1 AS wbl_nonfood_id
  ,-1 AS wbl_kasse_id
  ,-1 AS frische_manager_id
  ,-1 AS regionale_psb_id
  ,0 AS tankstelle_vorh_fg
  ,-1 AS tankstelle_eigen_fg
  ,-1 AS ma_vermietung_id
  ,0 AS eigentum_fg
  ,NULL AS dat_letzte_reorga
  ,-1 AS parkhaus_kz
  ,-1 AS getraenkemarkt_kz
  ,0 AS anz_aufzuege
  ,0 AS anz_rollsteige
  ,0 AS anz_aufzuege_intern
  ,0 AS anz_rollsteige_intern
  ,'' AS untervermietung_kz
  ,'' AS untervermietung_text
  ,'' AS untervermietung_freitext
  ,COALESCE(d.hausleiter_sperr_fg,0) AS hausleiter_sperr_fg
  ,COALESCE(d.vkl_sperr_fg,0) AS vkl_sperr_fg
  ,COALESCE(d.gf_gbl_vertrieb_sperr_fg,0) AS gf_gbl_vertrieb_sperr_fg
  
FROM DBP_DATA.wup w
LEFT JOIN DBP_MSI_DATA.wup_denorm d
ON d.mandant_id = w.mandant_id
AND d.wup_id = w.wup_id

WHERE nb_id = 0
;

UPDATE DBP_ETL.wup_denorm_tmp
SET bed_fleisch_fg      = r.bed_fleisch_fg
  ,bed_fleisch_dat      = r.bed_fleisch_dat
  ,bed_wurst_fg         = r.bed_wurst_fg
  ,bed_wurst_dat        = r.bed_wurst_dat
  ,bed_gefl_fg          = r.bed_gefl_fg
  ,bed_gefl_dat         = r.bed_gefl_dat
  ,bed_kaese_fg         = r.bed_kaese_fg
  ,bed_kaese_dat        = r.bed_kaese_dat
  ,bed_fisch_id         = r.bed_fisch_id
  ,bed_fisch_dat        = CASE WHEN r.bed_fisch_id <> 1 THEN r.bed_fisch_dat ELSE NULL END
  ,bed_feink_fg         = r.bed_feink_fg
  ,bed_feink_dat        = r.bed_feink_dat
  ,bed_bulk_fg          = r.bed_bulk_fg
  ,bed_bulk_dat         = r.bed_bulk_dat
  ,bed_bedins_fg        = r.bed_bedins_fg
  ,bed_bedins_dat       = r.bed_bedins_dat
  ,bed_imbiss_fg        = r.bed_imbiss_fg
  ,bed_imbiss_dat       = r.bed_imbiss_dat
  ,bed_backshop_fg      = r.bed_backshop_fg
  ,bed_backshop_dat     = r.bed_backshop_dat
  ,backshop_system      = COALESCE(r.backshop_system, '')
  ,leergut_system       = COALESCE(CASE WHEN r.leergut_system = 'Leergutautomaten' THEN 'Leergutautomat' ELSE r.leergut_system END, '')
  ,anz_leergutautomaten = COALESCE(r.anz_leergutautomaten, 0)

FROM
(
  SELECT
     r.mandant_id
    ,r.wup_id
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FLEISCH' AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_fleisch_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FLEISCH' AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_fleisch_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_WURST'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_wurst_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_WURST'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_wurst_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_GEFL'    AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_gefl_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_GEFL'    AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_gefl_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_KAESE'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_kaese_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_KAESE'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_kaese_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FISCH'   AND dat_bedienkonzept < CURRENT_DATE THEN b.bedienkonzept_auspr_id  ELSE 1 END)  /*1=nix*/               AS bed_fisch_id
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FISCH'   THEN dat_bedienkonzept ELSE NULL END)                                                            AS bed_fisch_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FEINK'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_feink_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FEINK'   AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_feink_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_BULK'    AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)  AS bed_bulk_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_BULK'    AND LOWER(bedienkonzept_auspr_bez) LIKE '%bed%' THEN dat_bedienkonzept ELSE NULL END)            AS bed_bulk_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_BEDINS'  AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END)   AS bed_bedins_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_BEDINS'  AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' THEN dat_bedienkonzept ELSE NULL END)             AS bed_bedins_dat
    ,MAX(CASE WHEN r.mandant_id = 1 /*DE aus Nebenbetrieb nb_id = 2*/
              THEN COALESCE (i.bed_imbiss_fg, 0)
              ELSE CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_IMBISS'  AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END
         END) AS bed_imbiss_fg
    ,MAX(CASE WHEN r.mandant_id = 1 /*DE aus Nebenbetrieb nb_id = 2*/
              THEN i.bed_imbiss_dat
              ELSE CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_IMBISS'  AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' THEN dat_bedienkonzept ELSE NULL END
         END) AS bed_imbiss_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) IN ('ZPPM_FRISCHB', 'ZPPM_DISCOUNT','ZPPM_BACKSHOPBED') AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 1 ELSE 0 END) AS bed_backshop_fg
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) IN ('ZPPM_FRISCHB', 'ZPPM_DISCOUNT','ZPPM_BACKSHOPBED') AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' THEN dat_bedienkonzept ELSE NULL END)           AS bed_backshop_dat
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_FRISCHB'  AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 'Frischebäcker'
              WHEN UPPER(bedienkonzept_bez) = 'ZPPM_DISCOUNT' AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 'Discountbackshop'
              WHEN UPPER(bedienkonzept_bez) = 'ZPPM_BACKSHOPBED' AND LOWER(bedienkonzept_auspr_bez) LIKE '%ja%' AND dat_bedienkonzept < CURRENT_DATE THEN 'Backshop in Bedienung'
              ELSE ''
         END) AS backshop_system
    ,MAX(CASE WHEN UPPER(bedienkonzept_bez) = 'ZPPM_LEERGUT' THEN bedienkonzept_auspr_bez END ) AS leergut_info
    ,TRY_TO_DECIMAL(SUBSTRING(leergut_info, 1, 1)) AS anz_leergutautomaten

    ,CASE WHEN anz_leergutautomaten IS NOT NULL
          THEN TRIM(SUBSTRING(leergut_info, 2, 100))
          ELSE TRIM(leergut_info)
     END AS leergut_system
  FROM DBP_DATA.rpm_immobilie_per r

  INNER JOIN DBP_DATA.rpm_hier_bed_konzept_zu_per b
  ON r.rpm_hierarchie_id = b.rpm_hierarchie_id
    AND b.dat_bis= to_date('9999-12-31','YYYY-MM-DD')

  -- Nur bestehende Objekte ber?cksichtigen
  INNER JOIN DBP_DATA.l_rpm_tab t
  ON t.rpm_tab_id = 3
    AND b.rpm_tab_id = t.rpm_tab_id

  INNER JOIN DBP_DATA.l_bedienkonzept k
  ON k.bedienkonzept_id = b.bedienkonzept_id

  INNER JOIN DBP_DATA.bedienkonzept_auspr_spr_zu a
  ON b.bedienkonzept_id = a.bedienkonzept_id
    AND b.bedienkonzept_auspr_id = a.bedienkonzept_auspr_id
    AND a.spr_id = 22

  -- F?r DE wird Imbiss nicht ?ber RPM gepflegt da separate Firma
  -- tempor?re Loesung ueber nb_id = 2
  LEFT OUTER JOIN
  (
    SELECT
       mandant_id
      ,haupt_wup_id AS wup_id
      ,MAX
       (
         CASE WHEN dat_eroeffnung < CURRENT_DATE
              THEN 1
              ELSE 0
         END
       ) AS bed_imbiss_fg
      ,MAX(dat_eroeffnung) AS bed_imbiss_dat
    FROM DBP_DATA.wup

    WHERE mandant_id = 1
      AND nb_id = 2
      AND CURRENT_DATE BETWEEN dat_von AND dat_bis
      AND wup_id not in (9902,9892,9882,9872) -- reine Kantinen aus Flagberechnung entfernen

    -- Sicher ist sicher....
    GROUP BY 1,2
  ) i
  ON r.mandant_id = i.mandant_id
    AND r.wup_id = i.wup_id

  WHERE r.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

  GROUP BY
     r.mandant_id
    ,r.wup_id
) r
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = r.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = r.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET 
   glv_land_id          = h.glv_land_id
  ,stv_glv_land_id      = h.stv_glv_land_id
  ,gl_vertrieb_id       = h.gl_vertrieb_id
  ,gf_gbl_vertrieb_id   = h.gf_gbl_vertrieb_id
  ,vkl_id               = h.vkl_id
  ,wbl_food_id          = h.wbl_food_id
  ,wbl_frische_id       = h.wbl_frische_id
  ,wbl_nonfood_id       = h.wbl_nonfood_id
  ,wbl_kasse_id         = h.wbl_kasse_id
  ,frische_manager_id   = h.frische_manager_id
  ,regionale_psb_id     = h.regionale_psb_id
  ,hausleiter_id        = h.hausleiter_id

FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,glv_land_id
    ,stv_glv_land_id
    ,gl_vertrieb_id
    ,gf_gbl_vertrieb_id
    ,vkl_id
    ,hausleiter_id
    ,wbl_food_id
    ,wbl_frische_id
    ,wbl_nonfood_id
    ,wbl_kasse_id
    ,frische_manager_id
    ,regionale_psb_id
  FROM DBP_ETL.ma_denorm

) h

WHERE DBP_ETL.wup_denorm_tmp.mandant_id = h.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = h.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET eigentum_fg = u.eigentum_fg
  , ma_vermietung_id = u.ma_vermietung_id
  , tankstelle_vorh_fg = u.tankstelle_vorh_fg
  -- Tankstelle eigen/fremd mit -1 vorbelegen wenn keine Tanke vorhanden ist.
  , tankstelle_eigen_fg = CASE WHEN u.tankstelle_vorh_fg = 0
                               THEN -1
                               ELSE 0
                           END

FROM
(
  SELECT
     a.mandant_id
    ,wup_id
    ,CASE WHEN a.mandant_id <> 8 THEN m.ma_id  ELSE m1.ma_id END AS ma_vermietung_id
    ,CASE WHEN eigentum_bez = 'Eigentum'
          THEN 1
          ELSE 0
     END AS eigentum_fg
    ,COALESCE(tankstelle_vorh_fg, 0) AS tankstelle_vorh_fg
  FROM
  (
    SELECT
      t. mandant_id
      ,POSITION(tp_ol_vermietung, ' ') AS idx
      ,CASE WHEN idx > 0
            THEN TRIM(SUBSTRING(tp_ol_vermietung, idx+1, 100))
            ELSE tp_ol_vermietung
       END AS nachname
      ,CASE WHEN idx > 0
            THEN TRIM(SUBSTRING(tp_ol_vermietung, 1, idx))
            ELSE ''
       END AS vorname
     ,wup_id
    , t.eigentum_bez
    ,t.tankstelle_vorh_fg
    FROM DBP_DATA.techn_platz_ebene_2_per t

    INNER JOIN DBP_DATA.techn_platz_per p
    ON t.mandant_id = p.mandant_id
      AND t.techn_platz_id = p.techn_platz_id
      AND p.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

    WHERE t.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
      AND t.mandant_id > 1
  ) a
  JOIN DBP_DATA.l_ma l
    ON a.mandant_id = l.mandant_id
  LEFT OUTER JOIN DBP_DATA.ma_spr_zu m
  ON l.ma_id = m.ma_id
    AND COALESCE(nachname, '') = m.ma_name
    AND COALESCE(vorname, '') = m.ma_vorname
    AND m.spr_id = 22

  LEFT OUTER JOIN DBP_DATA.ma_spr_zu m1
  ON l.ma_id = m1.ma_id
    AND COALESCE(nachname, '') = m1.ma_name
    AND COALESCE(vorname, '') = m1.ma_vorname
    AND m1.spr_id = 18

QUALIFY row_number() over (partition by 1,2 order by m.ma_anrede DESC)=1
) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET eigentum_fg         = u.eigentum_fg
  , ma_vermietung_id    = u.ma_vermietung_id
  , tankstelle_vorh_fg  = u.tankstelle_vorh_fg
  -- Tankstelle eigen/fremd mit -1 vorbelegen wenn keine Tanke vorhanden ist.
  , tankstelle_eigen_fg = CASE WHEN u.tankstelle_vorh_fg = 0 THEN -1 ELSE 0 END

FROM
( SELECT mandant_id, wup_id,max(ma_vermietung_id) ma_vermietung_id,tankstelle_vorh_fg,eigentum_fg 
  FROM(
        SELECT
                 we.mandant_id as mandant_id
                ,we.wirtschaftseinheit_id AS wup_id
               
                ,Coalesce(v1.partner_id,0) AS ma_vermietung_id
                ,MAX(CASE WHEN mo.branche_id = 150  THEN 1 ELSE 0 END) AS tankstelle_vorh_fg
                ,MAX(CASE WHEN we.besitzstatus_id = '3' THEN 1 ELSE 0 END) AS eigentum_fg
        FROM    DBP_DATA.immo_wirtschaftseinheit we
        LEFT JOIN  DBP_DATA.immo_mietobjekt mo
          ON    we.mandant_id = mo.mandant_id
          AND   we.we_intreno = mo.we_intreno
        LEFT JOIN
                ( SELECT 
                        v00.partner_id
                        ,v01.we_intreno
                FROM DBP_DATA.immo_l_partner v00
                INNER JOIN DBP_DATA.immo_we_partner_rolle_zu_per v01 
                        ON v00.partner_id = v01.partner_id
                WHERE Current_Date BETWEEN v01.dat_von AND v01.dat_bis
                AND v01.rolle_kz = 'ZI0104'
                )  v1 ON v1.we_intreno = we.we_intreno
        WHERE we.mandant_id = 1
        AND Current_Date BETWEEN dat_we_gueltig_von AND dat_we_gueltig_bis
        AND Current_Date BETWEEN dat_mo_gueltig_von AND dat_mo_gueltig_bis
        AND (we.mandant_id,we.we_intreno) NOT IN 
        (
                SELECT  mandant_id, we_intreno
                FROM    DBP_DATA.immo_wirtschaftseinheit
                WHERE   wirtschaftseinheit_bez LIKE '%paob%'
                   OR   wirtschaftseinheit_bez LIKE '%UMGL%'
        )
        AND ma_vermietung_id <>0
        AND dat_eroeffnung < CURRENT_DATE
        GROUP BY 1,2,3
  ) GROUP BY 1,2,4,5
) u

WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;



--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET tankstelle_eigen_fg = 1

FROM
(
  SELECT
     mandant_id
    ,haupt_wup_id
  FROM DBP_DATA.wup

  WHERE nb_id = 7
    AND dat_bis >= CURRENT_DATE
) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id          = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id              = u.haupt_wup_id
  AND DBP_ETL.wup_denorm_tmp.tankstelle_vorh_fg  = 1
;

UPDATE DBP_ETL.wup_denorm_tmp
SET tankstelle_eigen_fg = 1 ,
    tankstelle_vorh_fg = 1
WHERE mandant_id = 1 and wup_id in
(
3000 ,
3070 ,
3180 ,
3230,
3300
)
;


--translated statement
create volatile table _mv_projekt_bauabschnitt
as
(SELECT
  v01.mandant_id as mandant_id
, v01.cpr_ext_id  as cpr_ext_id
FROM DBP_DATA.cpr_projekt_per v01
JOIN DBP_DATA.cpr_phase_per  v02
ON v01.projekt_id = v02.projekt_id
AND v02.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND v01.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
GROUP BY 1,2
);

--translated statement
create volatile table _cpr_cl_punkt_termin
as
(SELECT
pt.mandant_id as mandant_id
,COALESCE(pt.wup_id,0) AS wup_id
,MAX(pt.dat_ende_ist) AS dat_ende_ist
FROM DBP_DATA.cpr_cl_punkt_termin pt

LEFT JOIN DBP_DATA.l_massnahme AS mn
ON mn.massnahme_id = pt.massnahme_id

LEFT JOIN DBP_DATA.cpr_projekt_per pr
ON pr.projekt_id = pt.projekt_id
AND pr.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

LEFT JOIN DBP_DATA.rpm_element_per el
ON pr.projekt_id = el.projekt_id
AND el.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

LEFT JOIN DBP_DATA.massnahmentyp_spr_zu AS msz
ON el.massnahmentyp_id = msz.massnahmentyp_id
AND msz.spr_id = 22

LEFT JOIN DBP_DATA.cpr_phase_spr_zu_per ph
ON pt.projekt_phase_id = ph.projekt_phase_id
AND pt.dat_ende_ist BETWEEN ph.dat_von and ph.dat_bis
AND ph.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND ph.spr_id = 22

LEFT JOIN DBP_DATA.cpr_aufgabe_per au
ON pt.projekt_phase_id = au.projekt_phase_id
AND pt.dat_ende_ist BETWEEN au.dat_von and au.dat_bis
AND au.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

JOIN _mv_projekt_bauabschnitt bas
ON pr.cpr_ext_id = bas.cpr_ext_id

WHERE pr.cpr_systemstatus1_id <> 4 or  pr.cpr_systemstatus1_id IS NULL
and pt.cpr_suchfeld = 'STILLE_EROEFFNUNG'
AND pt.massnahme_id IN ('RE', 'ZPPM_RE', 'RN', 'ZPPM_RN', 'ST', 'ZPPM_ST')
GROUP BY 1,2
);


UPDATE DBP_ETL.wup_denorm_tmp
SET dat_letzte_reorga = u.dat_letzte_reorga

FROM
(
        SELECT
        w.mandant_id
        ,w.wup_id
        ,t.dat_ende_ist AS dat_letzte_reorga
        FROM DBP_DATA.wup w 

        INNER JOIN
        (
        SELECT
           mandant_id
          ,wup_id
          ,MAX(dat_ende_ist) AS dat_ende_ist
        FROM _cpr_cl_punkt_termin       

        GROUP BY 1,2
        ) t
        ON w.mandant_id = t.mandant_id
        AND w.wup_id = t.wup_id

        WHERE w.nb_id = 0           /* ausschliesslich Filialen */
        AND umzugsfiliale_fg = 0  /* OHNE Umzugsfilialen >> dat_umzug in mv_wup */

) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET parkhaus_kz = u.parkhaus_kz

FROM
(
  SELECT
     t.mandant_id
    ,t.wup_id
    ,MAX
     (
       CASE WHEN g.techn_platz_id IS NOT NULL AND g.betreiberart_id = b.betreiberart_id THEN 1
            WHEN g.techn_platz_id IS NOT NULL THEN 0
            ELSE -1
       END
     ) AS parkhaus_kz
  FROM DBP_DATA.techn_platz_per  t

  LEFT OUTER JOIN DBP_DATA.ginfo_betr_t_platz_zu_per g
  ON t.techn_platz_id = g.techn_platz_id
    AND CURRENT_DATE BETWEEN g.dat_von AND g.dat_bis

  LEFT OUTER JOIN DBP_DATA.l_ginfo_betreiberart b
  ON UPPER(b.betreiberart_bez) = 'PARKHAUS'

  WHERE t.mandant_id = 1
    AND CURRENT_DATE BETWEEN t.dat_von AND t.dat_bis
    AND techn_platz_ebene_id = 2

  GROUP BY 1,2
) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET getraenkemarkt_kz = u.getraenkemarkt_kz

FROM
(
  SELECT
     t.mandant_id
    ,t.wup_id
    ,MAX
     (
       CASE WHEN g.techn_platz_id IS NOT NULL AND g.betreiberart_id = b.betreiberart_id THEN 1
            WHEN g.techn_platz_id IS NOT NULL THEN 0
            ELSE -1
       END
     ) AS getraenkemarkt_kz
  FROM DBP_DATA.techn_platz_per  t

  LEFT OUTER JOIN DBP_DATA.ginfo_betr_t_platz_zu_per g
  ON t.techn_platz_id = g.techn_platz_id
    AND CURRENT_DATE BETWEEN g.dat_von AND g.dat_bis

  LEFT OUTER JOIN DBP_DATA.l_ginfo_betreiberart b
  ON UPPER(b.betreiberart_bez) = 'SBW MIT SEPERATEM GETRÄNKEMARKT'

  WHERE t.mandant_id = 1
    AND CURRENT_DATE BETWEEN t.dat_von AND t.dat_bis
    AND techn_platz_ebene_id = 2

  GROUP BY 1,2
) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp
SET anz_aufzuege          = dt1.anz_aufzuege
   ,anz_aufzuege_intern   = dt1.anz_aufzuege_intern
   ,anz_rollsteige        = dt1.anz_rollsteige
   ,anz_rollsteige_intern = dt1.anz_rollsteige_intern

FROM
(
  SELECT
     t1.mandant_id
    ,t3.wup_id
    ,SUM
     (
       CASE WHEN t4.tp_merkmal_sap_id = 'CH_002_FM_002_006' THEN 1 ELSE 0 END
     ) AS anz_aufzuege
    ,SUM
     (
       CASE WHEN t4.tp_merkmal_sap_id = 'CH_002_FM_002_006' AND t1.tp_merkmalwert = '0001' THEN 1 ELSE 0 END
     ) AS anz_aufzuege_intern
    ,SUM
     (
       CASE WHEN t4.tp_merkmal_sap_id = 'CH_002_FM_016_006' THEN 1 ELSE 0 END
     ) AS anz_rollsteige
    ,SUM
     (
       CASE WHEN t4.tp_merkmal_sap_id = 'CH_002_FM_016_006' AND t1.tp_merkmalwert = '0001' THEN 1 ELSE 0 END
     ) AS anz_rollsteige_intern
  FROM DBP_DATA.tp_objekt_merkmal t1

  JOIN DBP_DATA.tp_objekt_per t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.tp_objekt_id = t2.tp_objekt_id

  JOIN DBP_DATA.techn_platz_per t3
  ON t2.techn_platz_id = t3.techn_platz_id

  JOIN DBP_DATA.l_tp_merkmal t4
  ON t1.tp_merkmal_id = t4.tp_merkmal_id

  WHERE t3.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
    AND t2.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
    AND t4.tp_merkmal_sap_id IN ('CH_002_FM_002_006', 'CH_002_FM_016_006')

  GROUP BY
     t1.mandant_id
    ,t3.wup_id
) dt1

WHERE DBP_ETL.wup_denorm_tmp.mandant_id = dt1.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = dt1.wup_id
;

--translated statement
UPDATE DBP_ETL.wup_denorm_tmp 
SET untervermietung_kz       = SUBSTRING(u.untervermietung_kz, 1, 20)
  , untervermietung_text     = SUBSTRING(u.untervermietung_text, 1, 160)
  , untervermietung_freitext = SUBSTRING(u.untervermietung_freitext, 1, 160) 

FROM 
(
  SELECT 
     mandant_id, immo_objekt_bez AS wup_id 
    ,MAX(CASE WHEN pos = 1 THEN TRIM(zustimmung_id) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 2 THEN ', ' || TRIM(zustimmung_id) ELSE '' END) || 
     MAX(CASE WHEN pos = 3 THEN ', ' || TRIM(zustimmung_id) ELSE '' END) || 
     MAX(CASE WHEN pos = 4 THEN ', ' || TRIM(zustimmung_id) ELSE '' END) || 
     MAX(CASE WHEN pos = 5 THEN ', ' || TRIM(zustimmung_id) ELSE '' END) || 
     MAX(CASE WHEN pos = 6 THEN ', ' || TRIM(zustimmung_id) ELSE '' END)
     AS untervermietung_kz
    ,MAX(CASE WHEN pos = 1 THEN TRIM(zustimmung_bez) ELSE '  ' END) || 
     MAX(CASE WHEN pos = 2 THEN ' / ' || TRIM(zustimmung_bez) ELSE '' END) || 
     MAX(CASE WHEN pos = 3 THEN ' / ' || TRIM(zustimmung_bez) ELSE '' END) || 
     MAX(CASE WHEN pos = 4 THEN ' / ' || TRIM(zustimmung_bez) ELSE '' END) || 
     MAX(CASE WHEN pos = 5 THEN ' / ' || TRIM(zustimmung_bez) ELSE '' END) || 
     MAX(CASE WHEN pos = 6 THEN ' / ' || TRIM(zustimmung_bez) ELSE '' END)
     AS untervermietung_text
    ,MAX(CASE WHEN pos = 1 THEN TRIM(bezeichnung) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 2 THEN ' / ' || TRIM(bezeichnung) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 3 THEN ' / ' || TRIM(bezeichnung) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 4 THEN ' / ' || TRIM(bezeichnung) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 5 THEN ' / ' || TRIM(bezeichnung) ELSE ' ' END) || 
     MAX(CASE WHEN pos = 6 THEN ' / ' || TRIM(bezeichnung) ELSE ' ' END)
     AS untervermietung_freitext
  FROM
  (
    SELECT 
       p.mandant_id
      ,to_char(p.buchungskreis_id,'9999') AS buchungskreis_id
      ,p.immo_objekt_bez
      ,p.objekt_name
      ,0    as zustimmung_id --t.zustimmung_id
      ,' '  as zustimmung_bez--t.zustimmung_bez
      ,' '  as bezeichnung--MAX(t.untervermietung_bez) AS bezeichnung
      ,0 as pos  --RANK() OVER(PARTITION BY p.mandant_id, p.immo_objekt_bez ORDER BY t.zustimmung_id ) AS pos 
    FROM DBP_DATA.ivs_immo_objekt_per p

    WHERE p.dat_bis = to_date('9999-12-31','YYYY-MM-DD') 
      AND objekt_name  NOT LIKE ('%UMGL%') 
      AND objekt_name NOT LIKE ( '%PAOB%')
      
      --Umgliederung ignorieren
      AND (p.mandant_id, p.immo_objekt_id) NOT IN
      (
        SELECT
           mandant_id
          ,immo_objekt_id
        FROM DBP_DATA.ivs_immo_objekt_per
    
        WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD')
          AND
            (
              dat_umgl > CURRENT_DATE /*Daten der Umgliederung in der Zukunft*/
              OR /*mindestens ein Satz vorhanden mit Umgliederung in der Vergangenheit*/
              (
                    status_umgl = 'UMGL'
                AND dat_umgl IS NULL
                AND (mandant_id, ref_immo_objekt_id) IN
                  (
                    SELECT
                       mandant_id
                      ,ref_immo_objekt_id
                    FROM DBP_DATA.ivs_immo_objekt_per
          
                    WHERE dat_umgl <= CURRENT_DATE
                      AND dat_bis = to_date('9999-12-31','YYYY-MM-DD') 
                  )
              )
            )
      )
    
    GROUP BY 1,2,3,4,5,6
  ) a
  GROUP BY 1,2
) u
WHERE DBP_ETL.wup_denorm_tmp.mandant_id = u.mandant_id
  AND DBP_ETL.wup_denorm_tmp.wup_id     = u.wup_id
;

--translated statement
CREATE  OR REPLACE TABLE DBP_ETL.vis_security_changes  (
   mandant_id             BYTEINT
  ,wup_id                 INTEGER
  ,gf_gbl_vertrieb_id_alt INTEGER
  ,gl_vertrieb_id_alt     INTEGER
  ,vkl_id_alt             INTEGER
  ,hausleiter_id_alt      INTEGER
  ,frische_manager_id_alt INTEGER
  ,gf_gbl_vertrieb_id_neu INTEGER
  ,gl_vertrieb_id_neu     INTEGER
  ,vkl_id_neu             INTEGER
  ,hausleiter_id_neu      INTEGER
  ,frische_manager_id_neu INTEGER
)
;

--translated statement
INSERT INTO DBP_ETL.vis_security_changes
(     
   mandant_id
  ,wup_id
  ,gf_gbl_vertrieb_id_alt
  ,gl_vertrieb_id_alt
  ,vkl_id_alt
  ,hausleiter_id_alt
  ,frische_manager_id_alt
  ,gf_gbl_vertrieb_id_neu
  ,gl_vertrieb_id_neu
  ,vkl_id_neu
  ,hausleiter_id_neu
  ,frische_manager_id_neu
)     
SELECT
   COALESCE(d.mandant_id, t.mandant_id) AS mandant_id
  ,COALESCE(d.wup_id, t.wup_id) AS wup_id
  -- alter Zustand
  ,d.gf_gbl_vertrieb_id AS gf_gbl_vertrieb_id_alt/*GF*/
  ,d.gl_vertrieb_id AS gl_vertrieb_id_alt /*VS, GL*/
  ,d.vkl_id AS vkl_id_alt
  ,d.hausleiter_id AS hausleiter_id_alt
  ,d.frische_manager_id AS frische_manager_id_alt
  -- neuer Zustand
  ,t.gf_gbl_vertrieb_id AS gf_gbl_vertrieb_id_neu/*GF*/
  ,t.gl_vertrieb_id AS gl_vertrieb_id_neu /*VS, GL*/
  ,t.vkl_id AS vkl_id_neu
  ,t.hausleiter_id AS hausleiter_id_neu
  ,t.frische_manager_id AS frische_manager_id_neu
FROM DBP_MSI_DATA.wup_denorm d
      
-- Markt existiert schon im Wup aber noch nicht in Denorm
RIGHT OUTER JOIN DBP_ETL.wup_denorm_tmp t
ON d.mandant_id = t.mandant_id
  AND d.wup_id = t.wup_id
      
WHERE 
  (   
       COALESCE(d.gf_gbl_vertrieb_id, -9999) <> COALESCE(t.gf_gbl_vertrieb_id, -9999)
    OR COALESCE(d.gl_vertrieb_id, -9999) <> COALESCE(t.gl_vertrieb_id, -9999)
    OR COALESCE(d.vkl_id, -9999) <> COALESCE(t.vkl_id, -9999)
    -- Info von Frau Binder am 24.05.2012: HL Wechsel ist nur interessant wenn
    -- Markt neu ist, Wechsel von HL A auf HL B sind fuer SD uninteressant
    OR (COALESCE(d.hausleiter_id, -9999) = -9999 AND COALESCE(t.hausleiter_id, -9999) <> -9999)
    OR COALESCE(d.frische_manager_id, -9999) <> COALESCE(t.frische_manager_id, -9999)
  )   
;


CREATE OR REPLACE TABLE DBP_ETL.vis_security_changes_1  (
   mandant_id             BYTEINT
  ,wup_id                 INTEGER
  ,gf_id_alt              INTEGER
  ,gf_anrede_alt          VARCHAR(40)
  ,gf_name_alt            VARCHAR(40)
  ,gf_vorname_alt         VARCHAR(40)
  ,gf_ldap_alt            VARCHAR(40)
  ,gl_id_alt              INTEGER
  ,gl_anrede_alt          VARCHAR(40)
  ,gl_name_alt            VARCHAR(40)
  ,gl_vorname_alt         VARCHAR(40)
  ,gl_ldap_alt            VARCHAR(40)
  ,vkl_id_alt             INTEGER
  ,vkl_anrede_alt         VARCHAR(40)
  ,vkl_name_alt           VARCHAR(40)
  ,vkl_vorname_alt        VARCHAR(40)
  ,vkl_ldap_alt           VARCHAR(40)
  ,hl_id_alt              INTEGER
  ,hl_anrede_alt          VARCHAR(40)
  ,hl_name_alt            VARCHAR(40)
  ,hl_vorname_alt         VARCHAR(40)
  ,hl_ldap_alt            VARCHAR(40)
  ,fm_id_alt              INTEGER
  ,fm_anrede_alt          VARCHAR(40)
  ,fm_name_alt            VARCHAR(40)
  ,fm_vorname_alt         VARCHAR(40)
  ,fm_ldap_alt            VARCHAR(40)
  ,gf_id_neu              INTEGER
  ,gf_anrede_neu          VARCHAR(40)
  ,gf_name_neu            VARCHAR(40)
  ,gf_vorname_neu         VARCHAR(40)
  ,gf_ldap_neu            VARCHAR(40)
  ,gl_id_neu              INTEGER
  ,gl_anrede_neu          VARCHAR(40)
  ,gl_name_neu            VARCHAR(40)
  ,gl_vorname_neu         VARCHAR(40)
  ,gl_ldap_neu            VARCHAR(40)
  ,vkl_id_neu             INTEGER
  ,vkl_anrede_neu         VARCHAR(40)
  ,vkl_name_neu           VARCHAR(40)
  ,vkl_vorname_neu        VARCHAR(40)
  ,vkl_ldap_neu           VARCHAR(40)
  ,hl_id_neu              INTEGER
  ,hl_anrede_neu          VARCHAR(40)
  ,hl_name_neu            VARCHAR(40)
  ,hl_vorname_neu         VARCHAR(40)
  ,hl_ldap_neu            VARCHAR(40)
  ,fm_id_neu              INTEGER
  ,fm_anrede_neu          VARCHAR(40)
  ,fm_name_neu            VARCHAR(40)
  ,fm_vorname_neu         VARCHAR(40)
  ,fm_ldap_neu            VARCHAR(40)
)
;


--translated statement
INSERT INTO DBP_ETL.vis_security_changes_1
(     
   mandant_id             
  ,wup_id                 
  ,gf_id_alt 
  ,gf_anrede_alt          
  ,gf_name_alt            
  ,gf_vorname_alt   
  ,gf_ldap_alt 
  
  ,gl_id_alt     
  ,gl_anrede_alt          
  ,gl_name_alt            
  ,gl_vorname_alt      
  ,gl_ldap_alt  
  
  ,vkl_id_alt             
  ,vkl_anrede_alt         
  ,vkl_name_alt           
  ,vkl_vorname_alt  
  ,vkl_ldap_alt 
  
  ,hl_id_alt      
  ,hl_anrede_alt          
  ,hl_name_alt            
  ,hl_vorname_alt  
  ,hl_ldap_alt  
  
  ,fm_id_alt 
  ,fm_anrede_alt          
  ,fm_name_alt            
  ,fm_vorname_alt  
  ,fm_ldap_alt 
  
  ,gf_id_neu 
  ,gf_anrede_neu          
  ,gf_name_neu            
  ,gf_vorname_neu  
  ,gf_ldap_neu 
  
  ,gl_id_neu     
  ,gl_anrede_neu          
  ,gl_name_neu            
  ,gl_vorname_neu 
  ,gl_ldap_neu 
  
  ,vkl_id_neu             
  ,vkl_anrede_neu         
  ,vkl_name_neu           
  ,vkl_vorname_neu      
  ,vkl_ldap_neu
  
  ,hl_id_neu      
  ,hl_anrede_neu          
  ,hl_name_neu            
  ,hl_vorname_neu   
  ,hl_ldap_neu 
  
  ,fm_id_neu 
  ,fm_anrede_neu          
  ,fm_name_neu            
  ,fm_vorname_neu 
  ,fm_ldap_neu
)   


SELECT
   COALESCE(d.mandant_id, t.mandant_id) AS mandant_id
  ,COALESCE(d.wup_id, t.wup_id) AS wup_id
  -- alter Zustand
  ,d.gf_gbl_vertrieb_id                        AS gf_id_alt
  ,COALESCE(ma_spr_zu_gf_alt.ma_anrede, '')    AS gf_anrede_alt
  ,COALESCE(ma_spr_zu_gf_alt.ma_name, '')      AS gf_name_alt
  ,COALESCE(ma_spr_zu_gf_alt.ma_vorname, '')   AS gf_vorname_alt
  ,COALESCE(ma_spr_zu_gf_alt.ma_ldap, '')      AS gf_ldap_alt
  
  ,d.gl_vertrieb_id                             AS gl_id_alt 
  ,COALESCE(ma_spr_zu_gl_alt.ma_anrede, '')     AS gl_anrede_alt
  ,COALESCE(ma_spr_zu_gl_alt.ma_name, '')       AS gl_name_alt
  ,COALESCE(ma_spr_zu_gl_alt.ma_vorname, '')    AS gl_vorname_alt
  ,COALESCE(ma_spr_zu_gl_alt.ma_ldap, '')       AS gl_ldap_alt
  
  ,d.vkl_id                                     AS vkl_id_alt
  ,COALESCE(ma_spr_zu_vkl_alt.ma_anrede, '')    AS vkl_anrede_alt
  ,COALESCE(ma_spr_zu_vkl_alt.ma_name, '')      AS vkl_name_alt
  ,COALESCE(ma_spr_zu_vkl_alt.ma_vorname, '')   AS vkl_vorname_alt
  ,COALESCE(ma_spr_zu_vkl_alt.ma_ldap, '')      AS vkl_ldap_alt
  
  ,d.hausleiter_id                              AS hl_id_alt
  ,COALESCE(ma_spr_zu_hl_alt.ma_anrede, '')     AS hl_anrede_alt
  ,COALESCE(ma_spr_zu_hl_alt.ma_name, '')       AS hl_name_alt
  ,COALESCE(ma_spr_zu_hl_alt.ma_vorname, '')    AS hl_vorname_alt
  ,COALESCE(ma_spr_zu_hl_alt.ma_ldap, '')       AS hl_ldap_alt
  
  ,d.frische_manager_id                         AS fm_id_alt
  ,COALESCE(ma_spr_zu_fm_alt.ma_anrede, '')     AS fm_anrede_alt
  ,COALESCE(ma_spr_zu_fm_alt.ma_name, '')       AS fm_name_alt
  ,COALESCE(ma_spr_zu_fm_alt.ma_vorname, '')    AS fm_vorname_alt
  ,COALESCE(ma_spr_zu_fm_alt.ma_ldap, '')       AS fm_ldap_alt
-- neuer Zustand
  ,t.gf_gbl_vertrieb_id                        AS gf_id_neu
  ,COALESCE(ma_spr_zu_gf_neu.ma_anrede, '')    AS gf_anrede_neu
  ,COALESCE(ma_spr_zu_gf_neu.ma_name, '')      AS gf_name_neu
  ,COALESCE(ma_spr_zu_gf_neu.ma_vorname, '')   AS gf_vorname_neu
  ,COALESCE(ma_spr_zu_gf_neu.ma_ldap, '')      AS gf_ldap_neu
  
  ,t.gl_vertrieb_id                            AS gl_id_neu 
  ,COALESCE(ma_spr_zu_gl_neu.ma_anrede, '')    AS gl_anrede_neu
  ,COALESCE(ma_spr_zu_gl_neu.ma_name, '')      AS gl_name_neu
  ,COALESCE(ma_spr_zu_gl_neu.ma_vorname, '')   AS gl_vorname_neu
  ,COALESCE(ma_spr_zu_gl_neu.ma_ldap, '')      AS gl_ldap_neu
  
  ,t.vkl_id                                    AS vkl_id_neu
  ,COALESCE(ma_spr_zu_vkl_neu.ma_anrede, '')   AS vkl_anrede_neu
  ,COALESCE(ma_spr_zu_vkl_neu.ma_name, '')     AS vkl_name_neu
  ,COALESCE(ma_spr_zu_vkl_neu.ma_vorname, '')  AS vkl_vorname_neu
  ,COALESCE(ma_spr_zu_vkl_neu.ma_ldap, '')      AS vkl_ldap_neu
  
  ,t.hausleiter_id                             AS hl_id_neu
  ,COALESCE(ma_spr_zu_hl_neu.ma_anrede, '')    AS hl_anrede_neu
  ,COALESCE(ma_spr_zu_hl_neu.ma_name, '')      AS hl_name_neu
  ,COALESCE(ma_spr_zu_hl_neu.ma_vorname, '')   AS hl_vorname_neu
  ,COALESCE(ma_spr_zu_hl_neu.ma_ldap, '')      AS hl_ldap_neu
  
  ,d.frische_manager_id                        AS fm_id_neu
  ,COALESCE(ma_spr_zu_fm_neu.ma_anrede, '')    AS fm_anrede_neu
  ,COALESCE(ma_spr_zu_fm_neu.ma_name, '')      AS fm_name_neu
  ,COALESCE(ma_spr_zu_fm_neu.ma_vorname, '')   AS fm_vorname_neu
  ,COALESCE(ma_spr_zu_fm_neu.ma_ldap, '')      AS fm_ldap_neu
FROM DBP_MSI_DATA.wup_denorm d
      
-- Markt existiert schon im Wup aber noch nicht in Denorm
RIGHT OUTER JOIN DBP_ETL.wup_denorm_tmp t
    ON d.mandant_id = t.mandant_id
   AND d.wup_id     = t.wup_id

LEFT OUTER JOIN dbp_etl_process.ma_spr_zu_save ma_spr_zu_gf_alt
    ON d.gf_gbl_vertrieb_id = COALESCE(ma_spr_zu_gf_alt.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_gf_alt.mandant_id
   AND ma_spr_zu_gf_alt.spr_id = 22
    
LEFT OUTER JOIN dbp_etl_process.ma_spr_zu_save ma_spr_zu_gl_alt
    ON d.gl_vertrieb_id = COALESCE(ma_spr_zu_gl_alt.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_gl_alt.mandant_id
   AND ma_spr_zu_gl_alt.spr_id = 22
   
LEFT OUTER JOIN dbp_etl_process.ma_spr_zu_save ma_spr_zu_vkl_alt
    ON d.vkl_id = COALESCE(ma_spr_zu_vkl_alt.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_vkl_alt.mandant_id
   AND ma_spr_zu_vkl_alt.spr_id = 22
   
LEFT OUTER JOIN dbp_etl_process.ma_spr_zu_save ma_spr_zu_hl_alt
    ON d.hausleiter_id = COALESCE(ma_spr_zu_hl_alt.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_hl_alt.mandant_id
   AND ma_spr_zu_hl_alt.spr_id = 22
  
LEFT OUTER JOIN dbp_etl_process.ma_spr_zu_save ma_spr_zu_fm_alt
    ON d.frische_manager_id = COALESCE(ma_spr_zu_fm_alt.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_fm_alt.mandant_id
   AND ma_spr_zu_fm_alt.spr_id = 22
  
LEFT OUTER JOIN DBP_DATA.ma_spr_zu  ma_spr_zu_gf_neu
    ON t.gf_gbl_vertrieb_id = COALESCE(ma_spr_zu_gf_neu.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_gf_neu.mandant_id
   AND ma_spr_zu_gf_neu.spr_id = 22
    
LEFT OUTER JOIN DBP_DATA.ma_spr_zu  ma_spr_zu_gl_neu
    ON t.gl_vertrieb_id = COALESCE(ma_spr_zu_gl_neu.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_gl_neu.mandant_id
   AND ma_spr_zu_gl_neu.spr_id = 22
   
LEFT OUTER JOIN DBP_DATA.ma_spr_zu  ma_spr_zu_vkl_neu
    ON t.vkl_id = COALESCE(ma_spr_zu_vkl_neu.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_vkl_neu.mandant_id
   AND ma_spr_zu_vkl_neu.spr_id = 22
   
LEFT OUTER JOIN DBP_DATA.ma_spr_zu  ma_spr_zu_hl_neu
    ON t.hausleiter_id = COALESCE(ma_spr_zu_hl_neu.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_hl_neu.mandant_id
   AND ma_spr_zu_hl_neu.spr_id = 22
  
LEFT OUTER JOIN DBP_DATA.ma_spr_zu  ma_spr_zu_fm_neu
    ON t.frische_manager_id = COALESCE(ma_spr_zu_fm_neu.ma_id,-1)
   AND COALESCE(d.mandant_id, t.mandant_id) = ma_spr_zu_fm_neu.mandant_id
   AND ma_spr_zu_fm_neu.spr_id = 22
 

WHERE 
  (   
        COALESCE(d.gf_gbl_vertrieb_id,    -9999) <> COALESCE(t.gf_gbl_vertrieb_id,    -9999)
     OR COALESCE(ma_spr_zu_gf_alt.ma_anrede, '') <> COALESCE(ma_spr_zu_gf_neu.ma_anrede, '')
     OR COALESCE(ma_spr_zu_gf_alt.ma_name,   '') <> COALESCE(ma_spr_zu_gf_neu.ma_name,   '') 
     OR COALESCE(ma_spr_zu_gf_alt.ma_vorname,'') <> COALESCE(ma_spr_zu_gf_neu.ma_vorname,'')
     OR COALESCE(ma_spr_zu_gf_alt.ma_ldap,   '') <> COALESCE(ma_spr_zu_gf_neu.ma_ldap,   '')
    
     OR COALESCE(d.gl_vertrieb_id,        -9999) <> COALESCE(t.gl_vertrieb_id,        -9999)
     OR COALESCE(ma_spr_zu_gl_alt.ma_anrede, '') <> COALESCE(ma_spr_zu_gl_neu.ma_anrede, '')
     OR COALESCE(ma_spr_zu_gl_alt.ma_name,   '') <> COALESCE(ma_spr_zu_gl_neu.ma_name,   '') 
     OR COALESCE(ma_spr_zu_gl_alt.ma_vorname,'') <> COALESCE(ma_spr_zu_gl_neu.ma_vorname,'')
     OR COALESCE(ma_spr_zu_gl_alt.ma_ldap,   '') <> COALESCE(ma_spr_zu_gl_neu.ma_ldap,   '')
    
     OR COALESCE(d.vkl_id,                 -9999) <> COALESCE(t.vkl_id,                 -9999)
     OR COALESCE(ma_spr_zu_vkl_alt.ma_anrede, '') <> COALESCE(ma_spr_zu_vkl_neu.ma_anrede, '')
     OR COALESCE(ma_spr_zu_vkl_alt.ma_name,   '') <> COALESCE(ma_spr_zu_vkl_neu.ma_name,   '') 
     OR COALESCE(ma_spr_zu_vkl_alt.ma_vorname,'') <> COALESCE(ma_spr_zu_vkl_neu.ma_vorname,'')
     OR COALESCE(ma_spr_zu_vkl_alt.ma_ldap,   '') <> COALESCE(ma_spr_zu_vkl_neu.ma_ldap,   '')

     OR (COALESCE(d.hausleiter_id, -9999) = -9999 AND COALESCE(t.hausleiter_id, -9999) <> -9999)
     OR COALESCE(ma_spr_zu_hl_alt.ma_anrede, '') <> COALESCE(ma_spr_zu_hl_neu.ma_anrede, '')
     OR COALESCE(ma_spr_zu_hl_alt.ma_name,   '') <> COALESCE(ma_spr_zu_hl_neu.ma_name,   '') 
     OR COALESCE(ma_spr_zu_hl_alt.ma_vorname,'') <> COALESCE(ma_spr_zu_hl_neu.ma_vorname,'')
     OR COALESCE(ma_spr_zu_hl_alt.ma_ldap,   '') <> COALESCE(ma_spr_zu_hl_neu.ma_ldap,   '')
    
     OR COALESCE(d.frische_manager_id,    -9999) <> COALESCE(t.frische_manager_id,    -9999)
     OR COALESCE(ma_spr_zu_fm_alt.ma_anrede, '') <> COALESCE(ma_spr_zu_fm_neu.ma_anrede, '')
     OR COALESCE(ma_spr_zu_fm_alt.ma_name,   '') <> COALESCE(ma_spr_zu_fm_neu.ma_name,   '') 
     OR COALESCE(ma_spr_zu_fm_alt.ma_vorname,'') <> COALESCE(ma_spr_zu_fm_neu.ma_vorname,'')
     OR COALESCE(ma_spr_zu_fm_alt.ma_ldap,   '') <> COALESCE(ma_spr_zu_fm_neu.ma_ldap,   '')
  )    
; 


SELECT
   a.mandant_id              AS mandant_id
  ,a.wup_id                  AS wup_id
  ,a.hierarchie_stufe        AS hierarchie_stufe
  ,CAST(ma_id_alt            AS CHAR(10)) AS ma_id_alt
  ,CAST(TRIM(anrede_alt)     AS CHAR(20)) AS anrede_alt
  ,CAST(TRIM(vorname_alt)    AS CHAR(40)) AS vorname_alt
  ,CAST(TRIM(name_alt)       AS CHAR(40)) AS name_alt
  ,CAST(TRIM(ldap_alt)       AS CHAR(40)) AS ldap_alt
  ,CAST(ma_id_neu            AS CHAR(10)) AS ma_id_neu
  ,CAST(TRIM(anrede_neu)     AS CHAR(20)) AS anrede_neu
  ,CAST(TRIM(vorname_neu)    AS CHAR(40)) AS vorname_neu
  ,CAST(TRIM(name_neu)       AS CHAR(40)) AS name_neu
  ,CAST(TRIM(ldap_neu)       AS CHAR(40)) AS ldap_neu
FROM
(       
        SELECT
         mandant_id         AS mandant_id
        ,wup_id             AS wup_id
        ,'GF '              AS hierarchie_stufe  
		,1                  AS hierarchie_stufe_id
        ,gf_id_alt          AS ma_id_alt
        ,gf_anrede_alt      AS anrede_alt
        ,gf_name_alt        AS name_alt
        ,gf_vorname_alt     AS vorname_alt
        ,gf_ldap_alt        AS ldap_alt
        ,gf_id_neu          AS ma_id_neu
        ,gf_anrede_neu      AS anrede_neu
        ,gf_name_neu        AS name_neu
        ,gf_vorname_neu     AS vorname_neu
        ,gf_ldap_neu        AS ldap_neu
        FROM DBP_ETL.vis_security_changes_1
        WHERE COALESCE(gf_id_alt, -9999) <> COALESCE(gf_id_neu, -9999)
           OR gf_vorname_alt   <> gf_vorname_neu
           OR gf_ldap_alt      <> gf_ldap_neu

        UNION

        SELECT
         mandant_id         AS mandant_id
        ,wup_id             AS wup_id
        ,'GL'               AS hierarchie_stufe 
		,2                  AS hierarchie_stufe_id
        ,gl_id_alt          AS ma_id_alt
        ,gl_anrede_alt      AS anrede_alt
        ,gl_name_alt        AS name_alt
        ,gl_vorname_alt     AS vorname_alt
        ,gl_ldap_alt        AS ldap_alt
        ,gl_id_neu          AS ma_id_neu
        ,gl_anrede_neu      AS anrede_neu
        ,gl_name_neu        AS name_neu
        ,gl_vorname_neu     AS vorname_neu
        ,gl_ldap_neu        AS ldap_neu
        FROM DBP_ETL.vis_security_changes_1
        WHERE COALESCE(gl_id_alt, -9999) <> COALESCE(gl_id_neu, -9999)
           OR gl_vorname_alt   <> gl_vorname_neu
           OR gl_ldap_alt      <> gl_ldap_neu

        UNION

        SELECT
         mandant_id         AS mandant_id
        ,wup_id             AS wup_id
        ,'VKL'              AS hierarchie_stufe 
		,3                  AS hierarchie_stufe_id
        ,vkl_id_alt         AS ma_id_alt
        ,vkl_anrede_alt     AS anrede_alt
        ,vkl_name_alt       AS name_alt
        ,vkl_vorname_alt    AS vorname_alt
        ,vkl_ldap_alt       AS ldap_alt
        ,vkl_id_neu         AS ma_id_neu
        ,vkl_anrede_neu     AS anrede_neu
        ,vkl_name_neu       AS name_neu
        ,vkl_vorname_neu    AS vorname_neu
        ,vkl_ldap_neu       AS ldap_neu
        FROM DBP_ETL.vis_security_changes_1
        WHERE COALESCE(vkl_id_alt, -9999) <> COALESCE(vkl_id_neu, -9999)
           OR vkl_vorname_alt   <> vkl_vorname_neu
           OR vkl_ldap_alt      <> vkl_ldap_neu
) a

WHERE (COALESCE(anrede_alt,'') <> ''
   OR COALESCE(vorname_alt,'') <> ''
   OR COALESCE(name_alt,'') <> ''
   OR COALESCE(TRIM(ldap_alt),'') <> ''
   OR COALESCE(anrede_neu,'') <> ''
   OR COALESCE(vorname_neu,'') <> ''
   OR COALESCE(name_neu,'') <> ''
   OR COALESCE(TRIM(ldap_neu),'') <> '')

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
;

--translated statement
DELETE FROM DBP_MSI_DATA.wup_denorm;

--translated statement
INSERT INTO DBP_MSI_DATA.wup_denorm
(     
   mandant_id
  ,wup_id
  ,bed_fleisch_fg
  ,bed_fleisch_dat
  ,bed_wurst_fg
  ,bed_wurst_dat
  ,bed_gefl_fg
  ,bed_gefl_dat
  ,bed_kaese_fg
  ,bed_kaese_dat
  ,bed_fisch_id
  ,bed_fisch_dat
  ,bed_feink_fg
  ,bed_feink_dat
  ,bed_bulk_fg
  ,bed_bulk_dat
  ,bed_bedins_fg
  ,bed_bedins_dat
  ,bed_imbiss_fg
  ,bed_imbiss_dat
  ,bed_backshop_fg
  ,bed_backshop_dat
  ,backshop_system
  ,leergut_system
  ,anz_leergutautomaten
  ,glv_land_id
  ,stv_glv_land_id
  ,gl_vertrieb_id
  ,gf_gbl_vertrieb_id
  ,vkl_id
  ,hausleiter_id
  ,wbl_food_id
  ,wbl_frische_id
  ,wbl_nonfood_id
  ,wbl_kasse_id
  ,frische_manager_id
  ,regionale_psb_id
  ,tankstelle_vorh_fg
  ,tankstelle_eigen_fg
  ,ma_vermietung_id
  ,eigentum_fg
  ,dat_letzte_reorga
  ,parkhaus_kz
  ,getraenkemarkt_kz
  ,anz_aufzuege
  ,anz_rollsteige
  ,anz_aufzuege_intern
  ,anz_rollsteige_intern
  ,untervermietung_kz
  ,untervermietung_text
  ,untervermietung_freitext
  ,hausleiter_sperr_fg
  ,vkl_sperr_fg
  ,gf_gbl_vertrieb_sperr_fg
)
SELECT
   mandant_id
  ,wup_id
  ,bed_fleisch_fg
  ,bed_fleisch_dat
  ,bed_wurst_fg
  ,bed_wurst_dat
  ,bed_gefl_fg
  ,bed_gefl_dat
  ,bed_kaese_fg
  ,bed_kaese_dat
  ,bed_fisch_id
  ,bed_fisch_dat
  ,bed_feink_fg
  ,bed_feink_dat
  ,bed_bulk_fg
  ,bed_bulk_dat
  ,bed_bedins_fg
  ,bed_bedins_dat
  ,bed_imbiss_fg
  ,bed_imbiss_dat
  ,bed_backshop_fg
  ,bed_backshop_dat
  ,backshop_system
  ,leergut_system
  ,anz_leergutautomaten
  ,glv_land_id
  ,stv_glv_land_id
  ,gl_vertrieb_id
  ,gf_gbl_vertrieb_id
  ,vkl_id
  ,hausleiter_id
  ,wbl_food_id
  ,wbl_frische_id
  ,wbl_nonfood_id
  ,wbl_kasse_id
  ,frische_manager_id
  ,regionale_psb_id
  ,tankstelle_vorh_fg
  ,tankstelle_eigen_fg
  ,ma_vermietung_id
  ,eigentum_fg
  ,dat_letzte_reorga
  ,parkhaus_kz
  ,getraenkemarkt_kz
  ,anz_aufzuege
  ,anz_rollsteige
  ,anz_aufzuege_intern
  ,anz_rollsteige_intern
  ,untervermietung_kz
  ,untervermietung_text
  ,untervermietung_freitext
  ,hausleiter_sperr_fg
  ,vkl_sperr_fg
  ,gf_gbl_vertrieb_sperr_fg
FROM DBP_ETL.wup_denorm_tmp;

--translated statement
UPDATE DBP_DATA.wup 
FROM DBP_MSI_DATA.wup_denorm wd

SET vkl_id = wd.vkl_id
   ,hl_id  = wd.hausleiter_id
   ,wm_id  = wd.frische_manager_id
   ,gf_id  = wd.gf_gbl_vertrieb_id
   ,td_update= CURRENT_TIMESTAMP
WHERE DBP_DATA.wup.mandant_id = wd.mandant_id
  AND (DBP_DATA.wup.wup_id    = wd.wup_id
        OR (DBP_DATA.wup.nb_id IN (2,7)
           AND DBP_DATA.wup.haupt_wup_id = wd.wup_id
           )
      )
;

--translated statement
UPDATE DBP_DATA.wup

SET vkl_id  = CASE WHEN COALESCE (vkl_id, -1) IN (-1, 0) THEN (1000 + mandant_id * 100 + vs_id * 10) * (-1) ELSE vkl_id END
   ,hl_id   = CASE WHEN COALESCE (hl_id, -1)  IN (-1, 0) THEN (1000 + mandant_id * 100 + vs_id * 10) * (-1) ELSE hl_id END
   ,gf_id   = CASE WHEN COALESCE (gf_id, -1)  IN (-1, 0) THEN (1000 + mandant_id * 100 + vs_id * 10) * (-1) ELSE gf_id END
   ,td_update= CURRENT_TIMESTAMP
WHERE nb_id IN (-2, -1)
  AND dat_eroeffnung > '1900-01-01'
  AND wup_id <> -1
;

--translated statement
DELETE FROM DBP_DATA.wm
;

--translated statement
INSERT INTO DBP_DATA.wm
(
       wm_id
      ,mandant_id
      ,wm_name
      ,td_insert
)
SELECT
       w.wm_id
      ,w.mandant_id
      -- Bulgarisch in kyrilisch speichern, kann dann in der View mittels Transcriptc umkodiert werden.
      ,CASE WHEN w.mandant_id <> 8
            THEN CAST (TRIM(ma1.ma_anrede) || ' ' || TRIM (ma1.ma_vorname) || ' ' || TRIM (ma1.ma_name) AS VARCHAR(40))
            ELSE CAST (TRIM(ma2.ma_anrede) || ' ' || TRIM (ma2.ma_vorname) || ' ' || TRIM (ma2.ma_name) AS VARCHAR(40))
       END
      ,CURRENT_TIMESTAMP
FROM
 (
  SELECT mandant_id
        ,wm_id
  FROM DBP_DATA.wup
  GROUP BY 1,2
 ) w

  INNER JOIN
     DBP_DATA.l_ma l
  ON  w.wm_id      = l.ma_id
  AND w.mandant_id = l.mandant_id

  INNER JOIN
     DBP_DATA.ma_spr_zu ma1
  ON  w.wm_id      = ma1.ma_id
  AND ma1.spr_id   = 22

 INNER JOIN
    DBP_DATA.mandant_spr_zu msz
  ON  w.mandant_id = msz.mandant_id

  LEFT OUTER JOIN
     DBP_DATA.ma_spr_zu ma2
  ON  w.wm_id      = ma2.ma_id
  AND msz.spr_id   = ma2.spr_id

;

--translated statement
DELETE FROM DBP_DATA.vkl
;

--translated statement
INSERT INTO DBP_DATA.vkl
(
      vkl_id
     ,mandant_id
     ,gf_id
     ,vkl_name
     ,td_insert
)
SELECT
       w.vkl_id
      ,w.mandant_id
      ,w.gf_gbl_vertrieb_id
      -- Bulgarisch in kyrilisch speichern, kann dann in der View mittels Transcriptc umkodiert werden.
      ,CASE WHEN w.mandant_id <> 8
            THEN CAST (TRIM(ma1.ma_anrede) || ' ' || TRIM (ma1.ma_vorname) || ' ' || TRIM (ma1.ma_name) AS VARCHAR(40))
            ELSE CAST (TRIM(ma2.ma_anrede) || ' ' || TRIM (ma2.ma_vorname) || ' ' || TRIM (ma2.ma_name) AS VARCHAR(40))
       END
      ,CURRENT_TIMESTAMP
FROM
 (SELECT x.mandant_id,
         x.vkl_id,
         x.gf_gbl_vertrieb_id
  FROM (SELECT mandant_id,
               vkl_id,
               gf_gbl_vertrieb_id,
               COUNT(*) AS anzahl
        FROM dbp_msi_data.wup_denorm
        GROUP BY 1,2,3) x
  QUALIFY ROW_NUMBER() OVER (PARTITION BY x.mandant_id,x.vkl_id ORDER BY x.anzahl DESC) = 1
  UNION
  SELECT mandant_id
        ,(1000 + mandant_id * 100 + vs_id * 10) * (-1)   AS vkl_id
        ,(1000 + mandant_id * 100 + vs_id * 10) * (-1)   AS gf_id
  FROM DBP_DATA.vs
 ) w
  INNER JOIN
     DBP_DATA.ma_spr_zu ma1
  ON  w.vkl_id     = ma1.ma_id
  AND ma1.spr_id   = 22

 INNER JOIN
    DBP_DATA.mandant_spr_zu msz
  ON  w.mandant_id = msz.mandant_id

  LEFT OUTER JOIN
     DBP_DATA.ma_spr_zu ma2
  ON  w.vkl_id     = ma2.ma_id
  AND msz.spr_id   = ma2.spr_id

;

--translated statement
DELETE FROM DBP_DATA.hl
;

--translated statement
INSERT INTO DBP_DATA.hl
(
      hl_id
     ,mandant_id
     ,hl_name
     ,td_insert
)
SELECT
       w.hl_id
      ,w.mandant_id
      -- Bulgarisch in kyrilisch speichern, kann dann in der View mittels Transcriptc umkodiert werden.
      ,CASE WHEN w.mandant_id <> 8
            THEN CAST (TRIM(ma1.ma_anrede) || ' ' || TRIM (ma1.ma_vorname) || ' ' || TRIM (ma1.ma_name) AS VARCHAR(40))
            ELSE CAST (TRIM(ma2.ma_anrede) || ' ' || TRIM (ma2.ma_vorname) || ' ' || TRIM (ma2.ma_name) AS VARCHAR(40))
       END
      ,CURRENT_TIMESTAMP
FROM
 (
  SELECT mandant_id
        ,hl_id
  FROM DBP_DATA.wup
  GROUP BY 1,2
 ) w
  INNER JOIN
     DBP_DATA.ma_spr_zu ma1
  ON  w.hl_id      = ma1.ma_id
  AND ma1.spr_id   = 22

 INNER JOIN
    DBP_DATA.mandant_spr_zu msz
  ON  w.mandant_id = msz.mandant_id

  LEFT OUTER JOIN
     DBP_DATA.ma_spr_zu ma2
  ON  w.hl_id      = ma2.ma_id
  AND msz.spr_id   = ma2.spr_id

;

--translated statement
DELETE FROM DBP_DATA.gf
WHERE ek_fg = 0
;

--translated statement
INSERT INTO DBP_DATA.gf
(
       gf_id
      ,mandant_id
      ,ek_fg
      ,gf_name
      ,td_insert
)
SELECT DISTINCT
      g.gf_id
     ,g.mandant_id
     ,0 AS ek_fg
      -- Bulgarisch in kyrilisch speichern, kann dann in der View mittels Transcriptc umkodiert werden.
      ,CASE WHEN g.mandant_id <> 8
            THEN CAST (TRIM(ma1.ma_anrede) || ' ' || TRIM (ma1.ma_vorname) || ' ' || TRIM (ma1.ma_name) AS VARCHAR(40))
            ELSE CAST (TRIM(ma2.ma_anrede) || ' ' || TRIM (ma2.ma_vorname) || ' ' || TRIM (ma2.ma_name) AS VARCHAR(40))
       END
      ,CURRENT_TIMESTAMP
FROM
   (SELECT gf_id
          ,mandant_id
    FROM DBP_DATA.vkl
    GROUP BY 1,2
   ) g

  INNER JOIN
     DBP_DATA.ma_spr_zu ma1
  ON  g.gf_id      = ma1.ma_id
  AND ma1.spr_id   = 22

 INNER JOIN
    DBP_DATA.mandant_spr_zu msz
  ON  g.mandant_id = msz.mandant_id

  LEFT OUTER JOIN
     DBP_DATA.ma_spr_zu ma2
  ON  g.gf_id      = ma2.ma_id
  AND msz.spr_id   = ma2.spr_id

;

--translated statement
UPDATE DBP_DATA.wup ziel
    SET verkaufsflaeche = quelle.fl_vk
  , betriebsflaeche = quelle.fl_betr
  , uebernahme_von  = quelle.uebernahme_von
  , td_update = CURRENT_TIMESTAMP
FROM (
  SELECT
     v02.mandant_id
    ,v02.wup_id
    ,v03.fl_vk
    ,v03.fl_betr
    ,COALESCE (SUBSTRING (v04.uebernahme_von, 1, 20), '')   AS uebernahme_von
  FROM DBP_DATA.techn_platz_per v02

  INNER JOIN
  ( -- G-Info
    SELECT
       mandant_id
      ,techn_platz_id
      -- vk_flaeche
      ,SUM(CASE WHEN ginfo_flaeche_typ_id IN ('VKF')
                     AND ginfo_flaeche_id IN ('02.01', '02.10', '02.08', '02.18', '02.02')
                THEN ginfo_flaeche_brutto
                ELSE 0
           END) AS fl_vk
      ,SUM(CASE WHEN (ginfo_flaeche_typ_id IN ('VKF')
                        AND ginfo_flaeche_id IN ('02.01', '02.10', '02.08', '02.18', '02.02') )
                    OR ginfo_flaeche_typ_id IN ('SNF', 'TF', 'VF', 'KOF', 'KOF-E')
                THEN ginfo_flaeche_brutto
                ELSE 0
           END) AS fl_betr
   FROM DBP_DATA.ginfo_flaeche_per  s01
   WHERE CURRENT_DATE BETWEEN s01.dat_von AND s01.dat_bis
   GROUP BY 1,2
 ) v03
 ON v02.techn_platz_id = v03.techn_platz_id

  LEFT OUTER JOIN
 (
   SELECT
      s01.mandant_id
     ,s01.techn_platz_id
     ,s01.uebernahme_von
   FROM DBP_DATA.techn_platz_ebene_2_per  s01
   WHERE s01.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
  ) v04
ON v02.techn_platz_id = v04.techn_platz_id

WHERE v02.techn_platz_ebene_id = 2
  AND v02.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
) quelle

WHERE ziel.mandant_id = quelle.mandant_id
  AND ziel.wup_id     = quelle.wup_id
  AND 
  (
    COALESCE(ziel.verkaufsflaeche, 0)    <> COALESCE(quelle.fl_vk, 0)
    OR COALESCE(ziel.betriebsflaeche, 0) <> COALESCE(quelle.fl_betr, 0)
    OR COALESCE(ziel.uebernahme_von, '') <> COALESCE(quelle.uebernahme_von, '')
  )
;


INSERT INTO DBP_MSI_DATA.user_vis_benchmark_zu
(
user_id
,mandant_id
,hierarchie_element_id
,hierarchie_ebene_id
,td_insert
,td_update
)
SELECT
         TRIM(m.land_id)||TRIM(w.wup_id)||'HL' AS user_id
        ,w.mandant_id   AS mandant_id
        ,w.wup_id       AS hierarchie_element_id
        ,'hl'           AS hierarchie_ebene_id
        ,CURRENT_TIMESTAMP
        ,CURRENT_TIMESTAMP
FROM    DBP_DATA.wup w
INNER JOIN DBP_ETL_PROCESS.land_mandant_zu m
ON      w.mandant_id = m.mandant_id

WHERE   w.dat_bis > CURRENT_DATE
AND     w.nb_id = 0
AND     (w.wup_id,w.mandant_id) NOT IN
        (SELECT hierarchie_element_id,mandant_id
         FROM DBP_MSI_DATA.user_vis_benchmark_zu
         WHERE hierarchie_ebene_id = 'hl'
        )
;

DELETE FROM DBP_MSI_DATA.user_wup_zu;
INSERT INTO DBP_MSI_DATA.user_wup_zu
(
         user_id
        ,mandant_id
        ,wup_id
        ,td_insert
        ,td_update
)
SELECT
         v.user_id
        ,v.mandant_id
        ,v.wup_id
        ,current_timestamp
        ,current_timestamp
FROM
(
        -- Hausleiter Ebene
        SELECT
                 user_id
                ,hl_bm.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu hl_bm
        INNER JOIN DBP_DATA.wup w
        ON LOWER(hl_bm.hierarchie_ebene_id) = 'hl'
        AND hl_bm.hierarchie_element_id = w.wup_id
        AND hl_bm.mandant_id =  w.mandant_id

        UNION

        -- Verkaufsleiter Ebene
        SELECT
                user_id
                ,vkl_bm.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu vkl_bm

        INNER JOIN DBP_MSI_DATA.wup_denorm w
        ON LOWER(vkl_bm.hierarchie_ebene_id)    = 'vkl'
        AND vkl_bm.hierarchie_element_id        = w.vkl_id
        AND vkl_bm.mandant_id                   = w.mandant_id

        UNION

        -- Vertriebsschiene (VS)  Ebene
        SELECT
                user_id
                ,vs_bm.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu vs_bm
        INNER JOIN DBP_DATA.wup w
        ON LOWER(vs_bm.hierarchie_ebene_id)     = 'vs'
        AND vs_bm.hierarchie_element_id         = w.vs_id
        AND vs_bm.mandant_id                    = w.mandant_id

        UNION

        -- GF Ebene
        SELECT
                user_id
                ,gf_bm.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu gf_bm

        INNER JOIN DBP_MSI_DATA.wup_denorm w
        ON LOWER(gf_bm.hierarchie_ebene_id)     = 'gf'
        AND gf_bm.hierarchie_element_id         = w.gf_gbl_vertrieb_id
        AND gf_bm.mandant_id                    = w.mandant_id

        UNION

        -- Vorstand  Ebene
        SELECT
                user_id
                ,vst_bm.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu vst_bm

        INNER JOIN DBP_DATA.wup w
        ON LOWER(vst_bm.hierarchie_ebene_id) = 'land'
        AND vst_bm.hierarchie_element_id = w.mandant_id

        UNION

        -- Vorstand Ebene  -1 bedeutet, alle Maerkte
        SELECT
                user_id
                ,w.mandant_id
                ,wup_id
        FROM DBP_MSI_DATA.user_vis_benchmark_zu vst_bm

        CROSS JOIN DBP_DATA.wup w
        WHERE vst_bm.hierarchie_element_id = -1
        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'

        UNION

        -- Vorstand Ebene  -2 bedeutet, alle KMO Maerkte
        SELECT
                user_id
                ,w.mandant_id
                ,wup_id
        FROM  DBP_MSI_DATA.user_vis_benchmark_zu vst_bm

        CROSS JOIN DBP_DATA.wup w
        WHERE w.mandant_id <> 1
        AND vst_bm.hierarchie_element_id = -2
        AND LOWER(vst_bm.hierarchie_ebene_id) = 'land'
) v

INNER JOIN DBP_DATA.wup w
ON      v.mandant_id    = w.mandant_id
AND     v.wup_id        = w.wup_id

WHERE   w.dat_eroeffnung IS NOT NULL
-- Maerkte bei denen Schliessungsdatum in letzten zwei Geschaeftsjahren liegt bzw. in der Zukunft (geoe ffnete MÃ¤rkte)
AND CAST(CAST((EXTRACT(YEAR FROM CURRENT_DATE)) - CASE WHEN EXTRACT(MONTH FROM CURRENT_DATE) IN (1,2,3) THEN 3 ELSE 2 END AS VARCHAR(4)) || '-03-01' AS DATE) <= w.dat_bis
AND  w.nb_id IN (0, -1) -- Maerkte und Zentralfilialen

GROUP BY 1,2,3
;

-- 25.01.2023, -dbay-
-- Protokolltabelle fuer Mitarbeitertexte.

delete from dbp_etl_process.ma_spr_zu_save;
insert into dbp_etl_process.ma_spr_zu_save (mandant_id
                                           ,ma_id
                                           ,spr_id
                                           ,ma_anrede
                                           ,ma_name
                                           ,ma_vorname
                                           ,email
                                           ,mobil_tel
                                           ,ma_ldap
                                           ,td_update
                                           ,td_insert)
select mandant_id
      ,ma_id
      ,spr_id
      ,ma_anrede
      ,ma_name
      ,ma_vorname
      ,email
      ,mobil_tel
      ,ma_ldap
      ,current_timestamp as td_update
      ,current_timestamp as td_insert
from dbp_data.ma_spr_zu
; 

-- 15.01.2025, -dbay-
-- Berechnung der Daten in Excel durch Vertrieb Int./ Einrichtung/ Standortkonzept für SOK-Reporting im VIS. Aufbereitung und Bereitstellung für DWH durch BC VIS

update dbp_msi_data.wup_denorm from (select *
                                     from dbp_etl_process.wup_denorm_k_stufe) b
                                 
set haeufigste_ultra_frische_listungsstufe_kz = b.haeufigste_ultra_frische_listungsstufe_kz,
    haeufigste_mopro_listungsstufe_kz = b.haeufigste_mopro_listungsstufe_kz,
    haeufigste_tiko_listungsstufe_kz = b.haeufigste_tiko_listungsstufe_kz,
    haeufigste_trocken_listungsstufe_kz = b.haeufigste_trocken_listungsstufe_kz,
    haeufigste_nonfood_listungsstufe_kz = b.haeufigste_nonfood_listungsstufe_kz
    
where dbp_msi_data.wup_denorm.mandant_id = b.mandant_id and
      dbp_msi_data.wup_denorm.wup_id = b.wup_id
;

-- 15.10.2025, -dbay-
-- Korrektur wegen falscher IOS-Werte.

update dbp_data.wup set verkaufsflaeche = 3159.39
where mandant_id = 5 and
      wup_id = 6520
;
