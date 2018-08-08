  # grabs nodes
    select distinct x.*
    from (select concat('gvNode:',table_name, ':', column_name) as `gvdata`
          from information_schema.key_column_usage
          where table_schema = "SCHEMA_NAME"

          UNION

          select concat('gvNode:',referenced_table_name, ':', referenced_column_name) as `gvdata`
          from information_schema.key_column_usage
          where referenced_table_name is not null
            and table_schema = "SCHEMA_NAME") x
    order by `gvdata` asc;

    select concat('gvEdge:', table_name, ':', column_name, ':', referenced_table_name, ':',
                  referenced_column_name) as 'gvdata'
    from information_schema.key_column_usage
    where referenced_table_name is not null
      and table_schema = "SCHEMA_NAME";
