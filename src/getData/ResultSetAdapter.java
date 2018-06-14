package getData;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.NoSuchElementException;

/**
 * Class that presents the contents of a JDBC result set as an iterable list of
 * maps.
 */
public class ResultSetAdapter implements Iterable<Map<String, Object>> {
    private ResultSet resultSet;
    private ResultSetMetaData resultSetMetaData;

    /**
     * Creates a new result set adapter.
     *
     * @param resultSet
     * The source result set.
     */
    
    public ResultSetAdapter(ResultSet resultSet) {
        if (resultSet == null) {
            throw new IllegalArgumentException();
        }

        this.resultSet = resultSet;
        try {
            resultSetMetaData = resultSet.getMetaData();
        } catch (SQLException exception) {
            throw new RuntimeException(exception);
        }
    }

    @Override
    public Iterator<Map<String, Object>> iterator() {
        return new Iterator<Map<String, Object>>() {
            private Boolean next = null;

            @Override
            public boolean hasNext() {
                if (next == null) {
                    try {
                        next = resultSet.next() ? Boolean.TRUE : Boolean.FALSE;
                    } catch (SQLException exception) {
                        throw new RuntimeException(exception);
                    }
                }

                return next.booleanValue();
            }

            @Override
            public Map<String, Object> next() {
                if (!hasNext()) {
                    throw new NoSuchElementException();
                }

                LinkedHashMap<String, Object> row = new LinkedHashMap<>();

                try {
                    for (int i = 0, n = resultSetMetaData.getColumnCount(); i < n; i++) {
                        row.put(resultSetMetaData.getColumnLabel(i + 1), resultSet.getObject(i + 1));
                    }
                } catch (SQLException exception) {
                    throw new RuntimeException(exception);
                }

                next = null;
                return row;
            }
        };
    }

    @Override
    public String toString() {
        return getClass().getName();
    }
}