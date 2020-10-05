from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello! Demo of image version management. This is a NEW verion 0.2")

