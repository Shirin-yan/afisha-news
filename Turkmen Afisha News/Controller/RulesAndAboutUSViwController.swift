//
//  RulesAndAboutUSViwController.swift
//  Turkmen Afisha News
//
//  Created by izi on 05.10.2021.
//

import UIKit

class SettingsAboutUsViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    let enContent = "<p>During the period of prosperity of developed State of Turkmenistan, at the initiative and support of Highly Esteemed President Gurbanguly Berdimuhamedov, we are able to evolve our national economy to the highest level, to develop an electronic industry, to build a developed economy based on the latest achievements, to develop information, communication, innovative, hi-tech and competitive economy. </p><p>Within the framework of the \"Concept for the Development of the Digital Economy of Turkmenistan\" approved by President for 2019-2025, the production industry in all fields of economy has been shifted to a digital mode at a rapid pace. The project Turkmen Afisha was established to support small and medium businesses. This project doesn’t have analogues in Turkmenistan and was developed by Individual Enterprise “Ide-Al hyzmat”. Turkmen Afisha was created to collect all services in a single platform, the interface of which is arranged and concretized. </p><p>Turkmen Afisha is the most convenient guide to Turkmenistan, i.e.: services, goods, shops, entertainment, food, sports, education, and more. </p><p>This project supports small and medium businesses giving entrepreneurs the opportunities, such as: creating private official accounts, supporting them with news and photos, large-scale informing and promoting business effectively. </p><p> Turkmen Afisha will help everyone with its information content and convenience. </p><p> Furthermore, in the project Turkmen Afisha you can find the most relevant information about the events taking place in Turkmenistan. </p><h3>DON\'T KNOW WHERE TO EAT? </h3><p> Our application will help you to find the best places where you will spend your time with pleasure and have a good meal. </p><h3>DON’T KNOW WHERE TO ORDER? </h3><p>Furniture, food, grocery, clothes, shoes, cosmetics, various services – all of this is available for users of Turkmen Afisha. </p><h3>DON\'T KNOW WHERE TO GO? </h3><p> The project Turkmen Afisha will help you to find the most suitable and interesting way to spend your time. </p><h3>SEARCHING FOR THE LATEST PROMOTIONS AND DISCOUNTS? </h3><p>Visit the section \"Promotions and Discounts\" in the application. </p><p> In our special section \"For Children\" every parent can find the desired product for their children. </p><p>Brighten up your life with the latest sports and entertainment news. </p><p> Become our official user and share your news, promotions and discounts. </p><p>  Collect the news important for you in \"Favorites\" for postponed offline reading. </p><p>Searching system can help with researching the content. </p><p>  Push - notifications will notify you about new publications. </p><p>Choose your region and get trending news of your region. </p><p>  Don\'t miss even a single event with Turkmen Afisha! </p><p>We are always pleased to cooperate! </p><p>Thank you for your trust! </p>"
    let ruContent = "<p>В период процветания многосторонне развитого государства Туркменистан по инициативе и поддержке Многоуважаемого Президента Гурбангулы Бердымухамедова, мы способны вознести на высший уровень нашу национальную экономику, развить электронную промышленность, строить развитую экономику на основе последних достижений, развивать информационную, коммуникационную, инновационную, высокотехнологичную, высоко конкурентную, и конкурентоспособную экономику. </p><p>В рамках \"Концепции развития цифровой экономики Туркменистана\", утвержденной Многоуважаемым Президентом на 2019-2025 года, производственная сфера во всех отраслях экономики с большими темпами стала переходить на цифровой режим. Для поддержания малого и среднего бизнеса был создан проект Turkmen Afisha. Этот проект не имеет аналогов в Туркменистане и была разработана индивидуальным предприятием “IDE-AL”. Turkmen Afisha была создана для собрания всех услуг в единой платформе, интерфейс которой предельно упорядочен и конкретизирован. </p><p>Turkmen Afisha – самый удобный гид по Туркменистану, а именно: услуги, товары, магазины, места развлечений, пищевые продукты, образование и многое другое. </p><p>\tПоддержание малого и среднего бизнеса заключается в возможностях, предоставленных предпринимателям данным проектом, а именно создание собственной официальной учетной записи, поддержание аккаунта новинками и свежими фотографиями, массовое информирование и эффективное продвижение бизнеса. </p><p>Turkmen Afisha поможет каждому человеку своей информативностью и удобством. </p><p>  Также, в проекте Turkmen Afisha Вы сможете найти самую актуальную информацию о событиях, происходящих в Туркменистане. </p><h3>НЕ ЗНАЕТЕ ГДЕ ПОЕСТЬ? </h3><p> Данный проект поможет вам отыскать самые лучшие места, где Вы проведете свое время с удовольствием и хорошо покушаете. </p><h3>НЕ ЗНАЕТЕ ГДЕ ЗАКАЗАТЬ? </h3><p>Мебель, еда, продукты питания, одежда, обувь, косметика, различные услуги – все это доступно для пользователей Turkmen Afisha. </p><h3> НЕ ЗНАЕТЕ КУДА ПОЙТИ? </h3><p>Turkmen Afisha поможет найти самый подходящий и интересный способ провести свое время. </p><h3>НЕ ЗНАЕТЕ ГДЕ СЕЙЧАС АКТУАЛЬНЫЕ АКЦИИ И СКИДКИ? </h3><p> Посетив раздел «Акции и Скидки» нашего проекта, Вы сможете получить актуальную информацию об акциях и скидках в вашем городе. </p><p>В нашем специальном разделе «Для Детей» каждый родитель сможет найти желанный продукт для своего ребенка. </p><p>Украсьте свою жизнь последними ежедневно обновляемыми новостями из мира спорта и развлечений. </p><p> Станьте нашим официальным пользователем и делитесь своими новостями.</p><p>Собирайте все важные для Вас новости в «Избранное» для отложенного чтения в режиме офлайн.</p><p> Благодаря удобной системе поиска можно с легкостью находить интересующие Вас материалы. </p><p> Push – уведомления оповестят о выходе новых публикаций, чтобы Вы оставались в курсе последних событий. </p><p> Ежедневно обновляемая база событий и новостей. </p><p>Получите последние и актуальные новости Вашего региона. </p><p>Не пропусти ни одного события с Turkmen Afisha! </p><p>Мы всегда рады сотрудничать с Вами и высоко ценим Ваше доверие! </p>"
    let tmContent = "<p>Türkmenistanyň dürli pudaklarda barha möwç alyp, gülläp ösýän döwründe Hormatly Prezidentimiz Gurbanguly Berdimuhamedowyň başlangyjy we goldawy bilen biz milli ykdysadyýetimizi iň ýokary derejä çykarmaga, elektron pudagyny ösdürmäge, soňky üstünlikleriň esasynda ösen ykdysadyýeti gurmaga, maglumat, aragatnaşyk, innowasion, ýokary tehnologiýaly, ýokary bäsdeşlikli we bäsdeşlige ukyply ykdysadyýeti ösdürmäge ukyplydyrys. </p><p>2019-2025-nji ýyllar üçin Hormatly Prezidentimiz tarapyndan tassyklanan \"Türkmenistanyň sanly ykdysadyýetini ösdürmek konsepsiýasynyň\" çäginde, ykdysadyýetiň ähli pudaklaryndaky önümçilik ulgamlary ýokary depginde sanly görnüşe  geçip başladylar. Kiçi we orta telekeçiligi goldamak üçin “Türkmen Afişa” taslamasy döredildi.  Türkmenistanda bu taslama meňzeş hiç bir taslama ýokdur. </p><p>Ol “IDE-AL” kärhanasy tarapyndan işlenip düzüldi. \"Türkmen Afişanyň\" interfeýsi ýokary derejede tertipleşdirilen we takyklaşdyrylan bolup, ol bir platformada ähli hyzmatlary jemlemek üçin döredilendir. </p><p>\"Türkmen Afişa\" Türkmenistan boýunça iň amatly gollanma bolmak bilen, hyzmatlar , harytlar, dükanlar, güýmenje, iýmit, bilim, sport we ş.m. barada maglumat berýär. </p><p>Kiçi we orta işewürligi goldamaklyk şu taslama tarapyndan telekeçilere berilýän mümkinçiliklerden, ýagny şahsy resmi agza bolmakdan, akkaundy täzelikler we täze suratlar bilen goldamakdan, köpçülikleýin habar berişden we biznesi netijeli öňe sürmekden ybarat bolup durýar. </p><p>\"Türkmen Afişa\" özüniň maglumat mazmuny we amatlylygy bilen her bir adama kömek eder. </p><p>Şeýle hem \"Türkmen Afişa\" taslamasynda Türkmenistanda bolup geçýän wakalar barada iň möhüm maglumatlary tapyp bilersiňiz. </p><h3>Nirede iýip-içmeli? </h3><p>Biziň taslamamyz wagtyňyzy gyzykly geçirip, lezzetli nahar iýmek üçin naýbaşy  ýerleri tapmaga size ýardam berer. </p><h3>Nireden sargamaly? <h3><p>Mebel, nahar, azyk harytlary, egin-eşik, aýakgap, kosmetika serişdeleri, dürli hyzmatlar – bularyň ählisi Turkmen Afisha taslamasynyň ulanyjylary üçin elýeterli. </p><h3>Nirä gitmeli? </h3><p>Şu taslama wagtyňyzy geçirmegiň iň amatly we gyzykly usulyny tapmaga kömek eder. </p><h3>Nirede iň elýeterli we amatly harytlar, arzanladyşlar bar? </h3><p>Biziň taslamamyzdaky \"Aksiýalar we arzanladyşlar\" bölümine girip, öz şäheriňizdäki aksiýalar we arzanladyşlar barada iň täze maglumatlary alyp bilersiňiz. </p><p>\"Çagalar üçin\" ýörite bölümimizde her bir ene-ata öz çagasy üçin islendik önümi tapyp biler. </p><p>Gündelik täzelenýän sport we güýmenje täzelikleri bilen durmuşyňyzy ýagtylandyryň!. </p><p> Biziň resmi ulanyjymyz bolup, täzelikleriňizi paýlaşyň. </p><p>Oflaýn görnüşinde okamak üçin soňa goýlan Size wajyp ähli täzelikleri \"Saýlananlar\" bölüminde ýygnaň. </p><p>Amatly gözleg ulgamynyň kömegi bilen gyzyklanýan islendik zadyňyzy aňsatlyk bilen tapyp bilersiňiz  </p><p>Push – habarlar siziň soňky wakalardan habarly bolmagyňyz üçin täze neşirler barada mälim eder. </p><p>Wakalaryň we täzelikleriň binýady gündelik täzelenip durýar. </p><p>Sebitiňiziň iň soňky täzeliklerinden habarly boluň! </p><p>\"Türkmen Afişa\" bilen hiç bir wakany göz öňüňizden ýitirmäň! </p><p>Biz hemişe siz bilen hyzmatdaşlyk etmäge şat we siziň ynamyňyza minnetdarlyk bildirýäris! </p> "
    
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = strInSelectedLang(lang: appLang, stingsToSelect: [enContent, ruContent, tmContent])
        lbl.attributedText = str.htmlToAttributedString
        
    }
    


}
