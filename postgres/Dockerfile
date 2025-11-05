# Use the official Postgres 15 image
FROM postgres:15

# Create a directory for PostgreSQL log files inside the container
# and ensure that the directory is owned by the 'postgres' user
RUN mkdir -p /var/log/postgresql && chown postgres:postgres /var/log/postgresql

# Enable PostgreSQL’s internal file-based logging (logging_collector)
# by appending configuration settings to the default configuration template.
# These lines modify the sample config file that the container uses when initializing a new database cluster.

# 1. Turn on the logging collector so that PostgreSQL writes logs to files (instead of stdout/stderr)
# 2. Set the log directory to /var/log/postgresql inside the container
# 3. Define the log file naming pattern (one log file per date/time)
RUN echo "logging_collector = on" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "log_directory = '/var/log/postgresql'" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'" >> /usr/share/postgresql/postgresql.conf.sample