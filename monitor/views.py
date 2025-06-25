from django.shortcuts import render, redirect
import time
from collections import defaultdict

# Global data structures
request_log = []
blocked_ips = set()
suspected_ips = []

def dashboard(request):
    global request_log, blocked_ips, suspected_ips

    current_time = time.time()
    ip = request.META.get('REMOTE_ADDR') or "192.168.0.1"

    # If IP is blocked, show blocked page
    if ip in blocked_ips:
        return render(request, 'monitor/dashboard.html', {
            'blocked': True,
            'ip': ip,
            'total_requests': 0,
            'ip_count': {},
            'suspected_ips': [],
            'recent_logs': [],
        })

    # Add request to log
    request_log.append((ip, current_time))

    # Keep only recent 10 seconds of requests
    request_log = [(ip, t) for ip, t in request_log if current_time - t <= 10]

    # Count requests per IP
    ip_count = defaultdict(int)
    for ip_addr, _ in request_log:
        ip_count[ip_addr] += 1

    # Detect suspected attackers
    suspected_ips = [ip for ip, count in ip_count.items() if count > 20]

    # Read recent log lines
    try:
        with open("attack_logs.txt", "r", encoding="utf-8") as f:
            lines = f.readlines()
            recent_logs = lines[-6:]
    except FileNotFoundError:
        recent_logs = []

    context = {
        'blocked': False,
        'ip': ip,
        'total_requests': len(request_log),
        'ip_count': dict(ip_count),
        'suspected_ips': suspected_ips,
        'recent_logs': recent_logs
    }

    return render(request, 'monitor/dashboard.html', context)


def stop_attack(request):
    global blocked_ips, suspected_ips

    # Block all detected attackers
    for ip in suspected_ips:
        blocked_ips.add(ip)

    # Log blocked IPs to file
# Log blocked IPs to file using UTF-8 encoding
    if suspected_ips:
        with open("attack_logs.txt", "a", encoding="utf-8") as f:
            f.write(f"\n---- {time.ctime()} ----\n")
            for ip in suspected_ips:
                f.write(f"⚠️ Blocked IP: {ip}\n")


    return redirect('dashboard')
