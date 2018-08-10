  # ensures primary keys appear as nodes; other nodes inferred from edges
    select distinct x.*
    from (select concat('gvNode:',table_name, ':', column_name) as `gvdata`
          from information_schema.key_column_usage
          where table_schema = "SCHEMA_NAME"
        and constraint_name = 'PRIMARY') x
    order by `gvdata` asc;

    select concat('gvEdge:', table_name, ':', column_name, ':', referenced_table_name, ':',
                  referenced_column_name) as 'gvdata'
    from information_schema.key_column_usage
    where referenced_table_name is not null
      and table_schema = "SCHEMA_NAME";
