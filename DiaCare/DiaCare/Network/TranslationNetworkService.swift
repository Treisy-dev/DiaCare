import Foundation
import Alamofire
import NaturalLanguage

enum TranslationOption {
    case toRussian
    case toEnglish
}

protocol TranslationNetworkServiceProtocol {
    func translateWord(word: String, completion: @escaping (Result<String, Error>) -> Void)
    func translateWordToRussian(word: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class TranslationNetworkService: TranslationNetworkServiceProtocol {

    let translationHeaders: HTTPHeaders = [
        "content-type": "application/json",
        "X-RapidAPI-Key": "9ae964ee58msh2d900e3833aeeb8p1de071jsn8d9ef4e557df",
        "X-RapidAPI-Host": "deep-translate1.p.rapidapi.com"
    ]

    var translationParameters: [String: Any] = [
        "q": "",
        "source": "ru",
        "target": "en"
    ]

    func translateWord(word: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let language = NLLanguageRecognizer.dominantLanguage(for: word) else { return }

        switch language {
        case .undetermined:
          completion(.failure(NSError(domain: "TranslationError", code: 0, userInfo: ["message": "Language detection failed"])))
        default:
            makeTranslationRequest(with: word, from: language.rawValue, to: "en") { result in
                switch result {
                case .success(let product):
                    completion(.success(product))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
      }

    func translateWordToRussian(word: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let language = NLLanguageRecognizer.dominantLanguage(for: word) else { return }
        switch language {
        case .undetermined:
          completion(.failure(NSError(domain: "TranslationError", code: 0, userInfo: ["message": "Language detection failed"])))
        default:
            makeTranslationRequest(with: word, from: language.rawValue, to: "ru") { result in
                switch result {
                case .success(let product):
                    completion(.success(product))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
      }

    private func makeTranslationRequest(with word: String, from: String, to: String, completion: @escaping (Result<String, Error>) -> Void) {
        translationParameters["q"] = word
        translationParameters["source"] = from
        translationParameters["target"] = to

        AF.request(
            "https://deep-translate1.p.rapidapi.com/language/translate/v2",
            method: .post,
            parameters: translationParameters,
            encoding: JSONEncoding.default,
            headers: translationHeaders
        ).responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let result = try JSONDecoder().decode(TranslationResponse.self, from: value)
                    let translatedText = result.data.translations.translatedText
                    completion(.success(translatedText))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
