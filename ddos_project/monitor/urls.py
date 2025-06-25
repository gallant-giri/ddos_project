from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('stop/', views.stop_attack, name='stop_attack'),
]
