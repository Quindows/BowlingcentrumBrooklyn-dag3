<?php

class Landingpages extends Controller
{

    public function __construct()
    {

    }

    public function index()
    {
        $data = [
            'title' => "Homepage MVC OOP Framework"
        ];
        $this->view('index', $data);
    }
}