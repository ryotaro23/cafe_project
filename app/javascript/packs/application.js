// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap/dist/css/bootstrap.min.css";
// BootstrapのJavaScript側の機能を読み込む
import "bootstrap";

// to use images in scss
const images = require.context('../images', true);
const imagePath = (name) => images(name, true);

import '../scss/application'
import './header'
import '../js/application'
