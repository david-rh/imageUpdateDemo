from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello Navy! Demo of image version management. This is version 0.3")

