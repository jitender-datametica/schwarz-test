/*
    CREATE V_REL_VALUE_CUBE_DOMAIN_HIERARCHY_2
*/

CREATE OR REPLACE VIEW transfer.v_rel_value_cube_domain_hierarchy_2(

 data_domain_cd         COMMENT 'Identifier code for data domains (eg. department name can be a data domain)',
   cube_level_type_cd   COMMENT 'Identifier for the level type of value cube (eg. order, product, customer).',
   cube_descr           COMMENT 'Description of the value cube.',
   display_order_nr     COMMENT 'Numbers displaying the visual sequential order.',
   value_pos_descr      COMMENT 'Description of the value cube position.',
   agg_pos_cd           COMMENT 'Identifier of the value cube position for the calculated subtotal/total.',
   calc_sign            COMMENT 'A binary indicator defining the multiplicative factor as +1 or -1.',
   value_pos_cd         COMMENT 'Identifier of the value cube position. Each metric can be a value cube position.'
) COMMENT= 'The relational view holding the logic needed to define the value cubes output based on parameters like value cube level, value cube positions, and aggregation logic.'

AS
WITH
    rel AS (
        SELECT
            data_domain_cd
            , cube_level_type_cd
            , cube_descr
            , value_pos_cd
            , value_pos_descr
            , agg_value_logic
            , factor_sign
            , display_order_nr
        FROM
            transfer.t_rel_value_cube_domain_hierarchy_2
    )
    , agg_rel AS (
        SELECT
            data_domain_cd
            , cube_level_type_cd
            , value_pos_cd
            , TO_VARCHAR( f.VALUE ) AS fval
            , IFNULL( NULLIF( SPLIT_PART( fval, '*', 0 ), fval ), 1 ) AS agg_sign
            , SPLIT_PART( fval, '*', -1 ) AS pos_kpi_id
        FROM
            rel AS t
            , LATERAL FLATTEN( INPUT => STRTOK_TO_ARRAY( REPLACE( t.agg_value_logic, '-', '+-1*' ), '+' ) ) AS f
    )
SELECT
    r.data_domain_cd
    , r.cube_level_type_cd
    , r.cube_descr 
    , r.display_order_nr
    , r.value_pos_descr
    , COALESCE( a.value_pos_cd, r.value_pos_cd )    AS agg_pos_cd
    , COALESCE( a.agg_sign, r.factor_sign )         AS calc_sign
    , COALESCE( a.pos_kpi_id, r.value_pos_cd )      AS value_pos_cd
FROM
    rel AS r
LEFT JOIN
    agg_rel AS a ON     r.value_pos_cd = a.value_pos_cd
                    AND r.data_domain_cd = a.data_domain_cd
                    AND r.cube_level_type_cd = a.cube_level_type_cd
ORDER BY
    r.display_order_nr
;