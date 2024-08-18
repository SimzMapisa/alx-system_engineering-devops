# Web Service Outage on Aug 10 2024 (Postmortem)

![How stressful it is when there is an outage](https://www.shutterstock.com/image-vector/man-overwork-office-deadline-vector-600nw-1039453264.jpg)

## Issue Summary

#### Duration
The outage lasted for 1 hour and 45 minutes, starting at 10:15 AM and ending at 12:00 PM UTC on August 10, 2024.

#### Impact
The outage affected approximately 60% of users attempting to access our web application. Users experienced slow loading times, with some receiving intermittent 502 Bad Gateway errors. The primary service impacted was the user authentication and session management system, which led to many users being unable to log in or maintain active sessions.

#### Root Cause
The root cause was an unexpected failure in the Redis cache cluster, which the authentication service relies on for session management. A configuration change in the Redis cluster led to an increased memory load, eventually causing it to crash.

#### Timeline
- **10:15 AM:** Issue detected via an automated monitoring alert indicating increased latency in the authentication service.
- **10:20 AM:** Initial investigation by the on-call engineer focused on the web servers, assuming a traffic spike caused the slowdown.
- **10:30 AM:** Further investigation ruled out traffic load as the cause. The team then checked the database for performance issues, suspecting a possible query bottleneck.
- **10:45 AM:** The database was found to be operating normally. The focus shifted to the Redis cluster after noticing increasing memory usage in the metrics.
- **11:00 AM:** Redis cluster was identified as the culprit. However, initial attempts to flush the cache to relieve memory pressure were unsuccessful.
- **11:15 AM:** The incident was escalated to the SRE (Site Reliability Engineering) team to assist with a deeper investigation into the Redis configuration.
- **11:30 AM:** The SRE team identified that a recent configuration change (increasing the max memory-policy to all keys-lru) was incompatible with the current memory limits.
- **11:45 AM:** The configuration was reverted, and the Redis nodes were restarted. The cache gradually warmed up, and service began to stabilize.
- **12:00 PM:** Full service was restored, and monitoring confirmed normal operation.
## Root Cause and Resolution
#### Root Cause
The root cause of the outage was a configuration change in the Redis cluster. The maxmemory-policy was changed to allkeys-lru to optimize cache performance. However, this policy caused an unexpectedly high memory load, leading to frequent evictions and, eventually, a crash of the Redis instances. The crash disrupted session management, as the authentication service relies heavily on Redis to store session data.

#### Resolution
The issue was resolved by reverting the Redis configuration to its previous state. Specifically, the maxmemory-policy was set back to volatile-lru, which only evicts keys with expiration times, thereby reducing memory load. After reverting the configuration, the Redis instances were restarted, and the cache began to warm up, restoring normal operation of the authentication service.

## Corrective and Preventative Measures
#### Improvements
- **Configuration Management:** Improve the process for deploying and testing configuration changes in critical services like Redis.
- **Monitoring Enhancements:** Implement more granular monitoring for Redis, including alerts for memory usage and eviction rates under different policies.
- **Load Testing:** Conduct load testing for all major configuration changes in a staging environment before deploying to production.
#### Task List
1. **Implement a Configuration Rollback Plan:** Develop a procedure to quickly revert to a previous configuration in case of unexpected failures.
2. **Patch Redis Nodes:** Update Redis to the latest version that includes performance improvements and better memory management features.
3. **Enhance Monitoring:** Add specific monitoring for Redis memory usage, eviction rates, and node health, with clear thresholds for alerts.
4. **Review Configuration Change Process:** Implement a review and approval process for configuration changes, including staging environment testing.
5. **Document Incident Response:** Create a detailed incident response runbook for Redis-related issues to guide engineers during similar future incidents.
## Conclusion
This incident highlighted the importance of rigorous testing and monitoring when making configuration changes in critical systems. The unexpected failure of the Redis cluster had a significant impact on user experience, underscoring the need for thorough validation before deploying changes to production environments.

Moving forward, we will implement stricter configuration management processes, enhance our monitoring capabilities, and ensure that all changes are thoroughly tested in a staging environment. By addressing these areas, we aim to prevent similar outages and improve the resilience of our services. Our focus will remain on minimizing downtime and maintaining a seamless experience for our users.
