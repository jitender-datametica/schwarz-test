CREATE OR REPLACE VIEW ldl_p_process_view.x_20190626_v_pit_msi_drill_detail_1071384_1 AS
-- PIT-20.01 Standard-Werbetermine Artikel_1 PV    C414B61311E92AEEA6D30080EF95527A
 -- || ','

-- E Vergleichshorizont = ?!
 -- || '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'

-- || CAST(base.adv_week_rltd_type_id AS STRING(5))
 -- AKU 20190318 added Vergleichswerbewoche

-- E Vergleichswerbewoche = ?!
 -- || '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'

-- || CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS STRING(12))

-- || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'

-- PIT-20.01 Standard-Werbetermine Artikel_1 PV    3A8FB5E511E934540BFF0080EFC5FDE2
 -- || ','

-- E Vergleichshorizont = ?!
 -- || '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'

-- || CAST(base.adv_week_rltd_type_id AS STRING(5))
 -- AKU 20190318 added Vergleichswerbewoche

-- E Vergleichswerbewoche = ?!
 -- || '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'

-- || CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS STRING(12))

-- || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'

-- PIT-20.02 Standard-Werbetermine Artikel_1 F+NF    037A6D2A11E92F94E1420080EF35DDE1
 -- || ','

-- E Vergleichshorizont = ?!
 -- || '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'

-- || CAST(base.adv_week_rltd_type_id AS STRING(5))
 -- AKU 20190318 added Vergleichswerbewoche

-- E Vergleichswerbewoche = ?!
 -- || '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'

-- || CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS STRING(12))

-- || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'

-- PIT-20.02 Standard-Werbetermine Artikel_1 F+NF    3C888FF411E93456287D0080EFE53CDF
 -- || ','

-- E Vergleichshorizont = ?!
 -- || '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'

-- || CAST(base.adv_week_rltd_type_id AS STRING(5))
 -- AKU 20190318 added Vergleichswerbewoche

-- E Vergleichswerbewoche = ?!
 -- || '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'

-- || CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS STRING(12))

-- || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'

SELECT BASE.client_id,
 BASE.adv_week_id,
 CAST(BASE.adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_sid,
 BASE.rltd_adv_week_id,
 CAST(BASE.rltd_adv_week_id * 100 + BASE.client_id AS BIGNUMERIC) AS adv_week_rltd_sid,
 BASE.adv_period_id,
 BASE.action_type_id,
  CASE
  WHEN BASE.action_type_id = 1 AND BASE.adv_period_id <> - 2
  THEN -- PV
 '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige f\u00c3\u00bcr '
                       || ATY.action_type_descr || ' f\u00c3\u00bcr Werbewoche ' || ADW.adv_week_descr ||
                    ' und Werbetermin: ' || CASE
                    WHEN ADP.adv_period_descr = 'TOT'
                    THEN 'Gesamt'
                    ELSE ADP.adv_period_descr
                    END || '" HREF="mstrWeb' -- ?
 || CHR(63) ||
                'evt=2048001&src=mstrWeb.2048001&documentID=C414B61311E92AEEA6D30080EF95527A'
                -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
 -- &pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373

                -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373'

                -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
 || '&elementsPromptAnswers='
               -- E  Land_1 ( Basic ) = ?!
 || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:' || CAST(BASE.client_id AS STRING)
              || ',' -- E Typ = ?!
 || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:' || CAST(ATY.action_type_id AS STRING)
           || ',' -- E Werbetermin = ?!
 || 'B26C01A746A154242340668A7A2BBA7C;B26C01A746A154242340668A7A2BBA7C:' || CAST(BASE.adv_period_id AS STRING)
        || ',' -- E Werbewoche = ?!
 || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:' || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING)
     ||
   '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
   -- AKU 20190219 Special TAG_1 --> TOT Overview

  WHEN BASE.action_type_id = 1 AND BASE.adv_period_id = - 2
  THEN -- PV
 '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige f\u00c3\u00bcr '
                    || ATY.action_type_descr || ' f\u00c3\u00bcr Werbewoche ' || ADW.adv_week_descr ||
                 ' und Werbetermin: ' || CASE
                 WHEN ADP.adv_period_descr = 'TOT'
                 THEN 'Alle Werbetermine'
                 ELSE ADP.adv_period_descr
                 END || '" HREF="mstrWeb' -- ?
 || CHR(63) ||
             'evt=2048001&src=mstrWeb.2048001&documentID=3A8FB5E511E934540BFF0080EFC5FDE2'
             -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
 -- &pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373

             -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373'

             -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
 || '&elementsPromptAnswers='
            -- E  Land_1 ( Basic ) = ?!
 || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:' || CAST(BASE.client_id AS STRING)
           || ',' -- E Typ = ?!
 || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:' || CAST(ATY.action_type_id AS STRING)
        || ',' -- E Werbewoche = ?!
 || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:' || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING)
     ||
   '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
   -- AKU 20190219 Removed TOT Exclusion

  WHEN BASE.action_type_id IN (2, 3) AND BASE.adv_period_id <> - 2
  THEN -- Drill auf Non Food and Food Actions

                       '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige f\u00c3\u00bcr '
                       || ATY.action_type_descr || ' f\u00c3\u00bcr Werbewoche ' || ADW.adv_week_descr ||
                    ' und Werbetermin: ' || CASE
                    WHEN ADP.adv_period_descr = 'TOT'
                    THEN 'Gesamt'
                    ELSE ADP.adv_period_descr
                    END || '" HREF="mstrWeb' -- ?
 || CHR(63) ||
                'evt=2048001&src=mstrWeb.2048001&documentID=037A6D2A11E92F94E1420080EF35DDE1'
                -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
 -- &pKey=WAC1684F0DCC744AB89C73B2C448E73AF

                -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=WAC1684F0DCC744AB89C73B2C448E73AF'

                -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
 || '&elementsPromptAnswers='
               -- E  Land_1 ( Basic ) = ?!
 || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:' || CAST(BASE.client_id AS STRING)
              || ',' -- E Typ = ?!
 || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:' || CAST(ATY.action_type_id AS STRING)
           || ',' -- E Werbetermin = ?!
 || 'B26C01A746A154242340668A7A2BBA7C;B26C01A746A154242340668A7A2BBA7C:' || CAST(BASE.adv_period_id AS STRING)
        || ',' -- E Werbewoche = ?!
 || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:' || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING)
     ||
   '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
   -- images/lidl/background/cm/PIT/appbar.magnify.add.png
 -- images/SearchIcon.gif

  WHEN BASE.action_type_id IN (2, 3) AND BASE.adv_period_id = - 2
  THEN -- Drill auf Non Food and Food Actions

                    '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige f\u00c3\u00bcr '
                    || ATY.action_type_descr || ' f\u00c3\u00bcr Werbewoche ' || ADW.adv_week_descr ||
                 ' und Werbetermin: ' || CASE
                 WHEN ADP.adv_period_descr = 'TOT'
                 THEN 'Alle Werbetermine'
                 ELSE ADP.adv_period_descr
                 END || '" HREF="mstrWeb' -- ?
 || CHR(63) ||
             'evt=2048001&src=mstrWeb.2048001&documentID=3C888FF411E93456287D0080EFE53CDF'
             -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
 -- &pKey=WAC1684F0DCC744AB89C73B2C448E73AF

             -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=WAC1684F0DCC744AB89C73B2C448E73AF'

             -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
 || '&elementsPromptAnswers='
            -- E  Land_1 ( Basic ) = ?!
 || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:' || CAST(BASE.client_id AS STRING)
           || ',' -- E Typ = ?!
 || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:' || CAST(ATY.action_type_id AS STRING)
        || ',' -- E Werbewoche = ?!
 || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:' || CAST((BASE.adv_week_id * 100) + BASE.client_id AS STRING)
     ||
   '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
   -- images/lidl/background/cm/PIT/appbar.magnify.add.png
 -- images/SearchIcon.gif

  ELSE NULL
  END AS drill_to_dokument_link_html
FROM ldl_p_lew_mart_analytics.v_pit_base_period_all_1 AS BASE
 INNER JOIN ldl_p_lew_mart_analytics.t_action_type_1 AS ATY ON BASE.action_type_id = ATY.action_type_id
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_period_1 AS ADP ON BASE.adv_period_id = ADP.adv_period_id
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_1 AS ADW ON BASE.adv_week_id = ADW.adv_week_id AND BASE.client_id = ADW
   .client_id;