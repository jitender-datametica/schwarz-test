CREATE OR REPLACE VIEW P_PROCESS_VIEW.X_20190626_V_PIT_MSI_DRILL_DETAIL_1071384_1 as
   SELECT
     base.client_id,
   base.adv_week_id,
   CAST( (base.adv_week_id * 100) + base.client_id AS INTEGER) AS adv_week_sid,
   base.rltd_adv_week_id,
   CAST( (base.rltd_adv_week_id * 100) + base.client_id AS INTEGER) AS adv_week_rltd_sid,
   base.adv_period_id,
   base.action_type_id,
   CASE WHEN base.action_type_id = 1 AND base.adv_period_id <> -2 THEN

             -- PV
             '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige fÃ¼r '
             || aty.action_type_descr
             || ' fÃ¼r Werbewoche '
             || adw.adv_week_descr
             || ' und Werbetermin: '
             || CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Gesamt' ELSE adp.adv_period_descr END

             || '" HREF="mstrWeb'
             -- ?
             || CHR(63)
             -- PIT-20.01 Standard-Werbetermine Artikel_1 PV    C414B61311E92AEEA6D30080EF95527A
             || 'evt=2048001&src=mstrWeb.2048001&documentID=C414B61311E92AEEA6D30080EF95527A'
             --&evt=2048076&src=mstrWeb.oivm.rwb.2048076'
             -- &pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373
             --|| '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373'
             --|| '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
             || '&elementsPromptAnswers='
             -- E  Land_1 ( Basic ) = ?!
             || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:'
             || CAST(base.client_id AS VARCHAR(12))
             || ','
             -- E Typ = ?!
             || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:'
             || CAST(aty.action_type_id AS VARCHAR(5))
             || ','
             -- E Werbetermin = ?!
             || 'B26C01A746A154242340668A7A2BBA7C;B26C01A746A154242340668A7A2BBA7C:'
             || CAST(base.adv_period_id AS VARCHAR(5))
             || ','
             -- E Werbewoche = ?!
             || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:'
             || CAST((base.adv_week_id * 100) + base.client_id AS VARCHAR(12))
             --|| ','
            -- E Vergleichshorizont = ?!
             --|| '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'
             --|| CAST(base.adv_week_rltd_type_id AS VARCHAR(5))
             -- AKU 20190318 added Vergleichswerbewoche
             -- E Vergleichswerbewoche = ?!
             --|| '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'
             --|| CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS VARCHAR(12))
             --|| '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'
             || '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
             -- AKU 20190219 Special TAG_1 --> TOT Overview

        WHEN base.action_type_id = 1 AND base.adv_period_id = -2 THEN

             -- PV
             '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige fÃ¼r '
             || aty.action_type_descr
             || ' fÃ¼r Werbewoche '
             || adw.adv_week_descr
             || ' und Werbetermin: '
             || CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Alle Werbetermine' ELSE adp.adv_period_descr END

             || '" HREF="mstrWeb'
             -- ?
             || CHR(63)
             -- PIT-20.01 Standard-Werbetermine Artikel_1 PV    3A8FB5E511E934540BFF0080EFC5FDE2
             || 'evt=2048001&src=mstrWeb.2048001&documentID=3A8FB5E511E934540BFF0080EFC5FDE2'
             --&evt=2048076&src=mstrWeb.oivm.rwb.2048076'
             -- &pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373
             --|| '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=W59DE6B1F5FC54A5ABA14C0FA1C23F373'
             --|| '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
             || '&elementsPromptAnswers='
             -- E  Land_1 ( Basic ) = ?!
             || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:'
             || CAST(base.client_id AS VARCHAR(12))
             || ','
             -- E Typ = ?!
             || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:'
             || CAST(aty.action_type_id AS VARCHAR(5))
             || ','
             -- E Werbewoche = ?!
             || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:'
             || CAST( (base.adv_week_id * 100) + base.client_id AS VARCHAR(12))
             --|| ','
             -- E Vergleichshorizont = ?!
             --|| '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'
             --|| CAST(base.adv_week_rltd_type_id AS VARCHAR(5))
             -- AKU 20190318 added Vergleichswerbewoche
             -- E Vergleichswerbewoche = ?!
             --|| '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'
             --|| CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS VARCHAR(12))
             --|| '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'
             || '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'

        -- AKU 20190219 Removed TOT Exclusion
        WHEN base.action_type_id IN (2,3) AND base.adv_period_id <> -2 THEN

             -- Drill auf Non Food and Food Actions
             '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige fÃ¼r '
             || aty.action_type_descr
             || ' fÃ¼r Werbewoche '
             || adw.adv_week_descr
             || ' und Werbetermin: '
             || CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Gesamt' ELSE adp.adv_period_descr END
             || '" HREF="mstrWeb'
             -- ?
             || CHR(63)
             --PIT-20.02 Standard-Werbetermine Artikel_1 F+NF    037A6D2A11E92F94E1420080EF35DDE1
             || 'evt=2048001&src=mstrWeb.2048001&documentID=037A6D2A11E92F94E1420080EF35DDE1'
             -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
             -- &pKey=WAC1684F0DCC744AB89C73B2C448E73AF
             -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=WAC1684F0DCC744AB89C73B2C448E73AF'
             -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
             || '&elementsPromptAnswers='
             -- E  Land_1 ( Basic ) = ?!
             || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:'
             || CAST(base.client_id AS VARCHAR(12))
             || ','
             -- E Typ = ?!
             || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:'
             || CAST(aty.action_type_id AS VARCHAR(5))
             || ','
             -- E Werbetermin = ?!
             || 'B26C01A746A154242340668A7A2BBA7C;B26C01A746A154242340668A7A2BBA7C:'
             || CAST(base.adv_period_id AS VARCHAR(5))
             || ','
             -- E Werbewoche = ?!
             || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:'
             || CAST( (base.adv_week_id * 100) + base.client_id  AS VARCHAR(12))
             --|| ','
             -- E Vergleichshorizont = ?!
             --|| '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'
             --|| CAST(base.adv_week_rltd_type_id AS VARCHAR(5))
             -- AKU 20190318 added Vergleichswerbewoche
             -- E Vergleichswerbewoche = ?!
             --|| '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'
             --|| CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS VARCHAR(12))

         --    || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'
             || '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
             -- images/lidl/background/cm/PIT/appbar.magnify.add.png
             -- images/SearchIcon.gif

        WHEN base.action_type_id IN (2,3) AND base.adv_period_id = -2 THEN

             -- Drill auf Non Food and Food Actions
             '<span style="background-color:#00A3E4;padding:7px 10px"><a style="color:#ffffff" title="Detailanzeige fÃ¼r '
             || aty.action_type_descr
             || ' fÃ¼r Werbewoche '
             || adw.adv_week_descr
             || ' und Werbetermin: '
             || CASE WHEN adp.adv_period_descr = 'TOT' THEN 'Alle Werbetermine' ELSE adp.adv_period_descr END
             || '" HREF="mstrWeb'
             -- ?
             || CHR(63)
             --PIT-20.02 Standard-Werbetermine Artikel_1 F+NF    3C888FF411E93456287D0080EFE53CDF
             || 'evt=2048001&src=mstrWeb.2048001&documentID=3C888FF411E93456287D0080EFE53CDF'
             -- &evt=2048076&src=mstrWeb.oivm.rwb.2048076'
             -- &pKey=WAC1684F0DCC744AB89C73B2C448E73AF
             -- || '&psKey=W8F6E642FC29B48D6B68C2791E12251DD&pKey=WAC1684F0DCC744AB89C73B2C448E73AF'
             -- || '&evtorder=2048001%2c2048076&2048001=1&2048076=1&evtwait=true'
             || '&elementsPromptAnswers='
             -- E  Land_1 ( Basic ) = ?!
             || '926BF6B847FEA8B861FDBBA4001A83D1;926BF6B847FEA8B861FDBBA4001A83D1:'
             || CAST(base.client_id AS VARCHAR(12))
             || ','
             -- E Typ = ?!
             || '3C2EEAAD4DF631361B0F2B9B3CD57E6F;3C2EEAAD4DF631361B0F2B9B3CD57E6F:'
             || CAST(aty.action_type_id AS VARCHAR(5))
             || ','
             -- E Werbewoche = ?!
             || '8FB350744E7A7CFAFE8D148F7666065A;8FB350744E7A7CFAFE8D148F7666065A:'
             || CAST( (base.adv_week_id * 100) + base.client_id AS VARCHAR(12))
             --|| ','
              -- E Vergleichshorizont = ?!
             --|| '0F7D774A418644BA070879AA18358ABF;0F7D774A418644BA070879AA18358ABF:'
             --|| CAST(base.adv_week_rltd_type_id AS VARCHAR(5))
             -- AKU 20190318 added Vergleichswerbewoche
             -- E Vergleichswerbewoche = ?!
             --|| '8C8AEE1F4CC673C7359B2B9F9F022F58;8C8AEE1F4CC673C7359B2B9F9F022F58:'
             --|| CAST( (base.rltd_adv_week_id * 100) + base.client_id  AS VARCHAR(12))
         --    || '" target="_blank">' || aty.action_type_descr || '-Details &nbsp; <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.png" width="16px" height="16px"></a></span>'
             || '" target="_blank"> <img style="margin:-5px" src="images/lidl/background/cm/PIT/appbar.magnify.add.white.png" width="24px" height="24px"></a></span>'
             -- images/lidl/background/cm/PIT/appbar.magnify.add.png
             -- images/SearchIcon.gif

        ELSE

             NULL

   END AS drill_to_dokument_link_html

 FROM  p_lew_mart_analytics.v_pit_base_period_all_1 AS base
   INNER JOIN  p_lew_mart_analytics.t_action_type_1 AS aty
   ON  base.action_type_id = aty.action_type_id
   INNER JOIN  p_lew_mart_analytics.t_advert_period_1 AS adp
   ON  base.adv_period_id = adp.adv_period_id
   INNER JOIN  p_lew_mart_analytics.t_advert_week_1 AS adw
   ON  base.adv_week_id = adw.adv_week_id
   AND base.client_id   = adw.client_id
;