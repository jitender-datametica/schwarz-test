CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SM_FOOD_HELPER_2
 AS
    -- HELPER : Sortimentkategorie/Profilierungswarengruppen Food SB pro Filiale
    -- REKURSION wird von mv_sm_food_rekursion_2 benoetigt
    -- 2012KW46 Initial (Q2)

    SELECT
    sm01.mandant_id
    , sm01.nb_id
    , sm01.wup_id
    , sm01.sm_id AS sst_food_id
    , sm02.sm_id
    , sm02.abt_id
    , sm02.wg_id
    --, COALESCE( TRIM(sm02.wg_id (FORMAT '999')),'-')::VARCHAR(3) AS wg
    --, COALESCE( 'WG' || (sm02.wg_id (FORMAT '999')),'-')::VARCHAR(5) AS wg_bez
    , case when sm02.wg_id is null then '-' else         trim(to_varchar(to_numeric(sm02.wg_id), 'FM000'))::varchar(5) end as wg
    , case when sm02.wg_id is null then '-' else 'WG' || trim(to_varchar(to_numeric(sm02.wg_id), 'FM000'))::varchar(5) end as wg_bez
    , RANK() OVER (PARTITION BY sm01.mandant_id, sm01.wup_id, sm01.sm_id ORDER BY sm01.mandant_id, sm01.wup_id, sm01.sm_id, sm02.wg_id) AS wg_count

    FROM
    ( -- Sortimentskategorie/-stufe Food (WG410)
    SELECT
    mandant_id, nb_id, wup_id, sm_id
    FROM dbp_view.v_sm_wup_wg_zu_per_2
    WHERE dat_bis = '9999-12-31'
    AND arthiertyp_id = 2
    AND nb_id = 0
    AND wg_id = 410 -- Leitwarengruppe Food
    AND sm_id >= 0

    AND mandant_id = 1 -- BIS Harmonisierung WG KMO

    ) as sm01
    LEFT JOIN
    ( -- Warengruppen Food Frische + Food Trocken mit abweichender SM_2
    SELECT
    sm.mandant_id, sm.wup_id, sm.sm_id, sm.wg_id, wg.abt_id
    FROM dbp_view.v_sm_wup_wg_zu_per_2 sm_2
    JOIN dbp_view.v_wg_per_2 wg
    ON sm.mandant_id = wg.mandant_id
    AND sm.wg_id = wg.wg_id

    WHERE sm.dat_bis = '9999-12-31'
    AND sm.arthiertyp_id = 2
    AND sm.nb_id = 0
    AND sm.sm_id >= 0
    AND wg.dat_bis = '9999-12-31'
    AND wg.arthiertyp_id = 2
    AND wg.abt_id IN (5,6) -- Food Frische/trocken SB

    AND sm.mandant_id = 1 -- BIS Harmonisierung WG KMO

    ) as sm02
    ON sm01.mandant_id = sm02.mandant_id
    AND sm01.wup_id = sm02.wup_id
    AND sm01.sm_id <> sm02.sm_id;