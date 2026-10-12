CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_reklamationsgrund_spr_2 AS SELECT V01.mandant_id,
 V01.reklamationsgrund_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.reklamationsgrund_bez
   ELSE NULL
   END) AS reklamationsgrund_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.reklamationsgrund_bez
   ELSE NULL
   END) AS reklamationsgrund_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.reklamationsgrund_bez
    ELSE NULL
    END)
  END AS reklamationsgrund_bez_bg,
 V02.mandant_kbez
FROM kfl_production_dbp_view.v_reklamationsgrund_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
GROUP BY V01.mandant_id,
 V01.reklamationsgrund_id,
 V02.mandant_kbez;