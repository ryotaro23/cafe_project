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

// Bootstrapのスタイルシート側の機能を読み込む
// webpack.config.jsでcssを読み取れるようにへんこうを加える
import "bootstrap/dist/css/bootstrap.min.css";
// BootstrapのJavaScript側の機能を読み込む
import "bootstrap";

import '../scss/application'
import './header'
import '../js/application'
const images = require.context('../images', true)
